//
//  HybridPreLoading.m
//  WebViewDemo
//
//  Created by 魏诗豪 on 16/3/13.
//  Copyright © 2016年 魏诗豪. All rights reserved.
//

#import "HybridPreLoading.h"
#import <UIKit/UIKit.h>
#import <YYCategories.h>

#define setWeakSelf  __weak __typeof(self)weakSelf = self

@implementation HybridPreLoading

static NSString * const hasInitKey = @"MyURLProtocolHandledKey";

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    if ([request.URL.scheme isEqualToString:@"http"]) {
        NSString *str = request.URL.absoluteString;
        
        if ([str containsString:@".mp4?sdtfrom="])
//        if ([HybridPreLoading rexString:str rex:@"*.mp4?sdtfrom=*" success:nil faild:nil])
        {
            NSLog(@"%@", str);
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = str;
            
            
            
            // 主线程执行：
            dispatch_async(dispatch_get_main_queue(), ^{
                // something
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"找到一个视频" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
            });
        }
        
        NSArray *sourceArr = @[@"img", @"js", @"css"];
        for (NSString *typeStr in sourceArr) {
            NSString *Regex = [HybridPreLoading addLocalFileReturnRex:typeStr];
            if ([HybridPreLoading rexString:str rex:Regex success:nil faild:nil] && ![NSURLProtocol propertyForKey:hasInitKey inRequest:request]) {
                return YES;
            }
        }
        
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    //这边可用干你想干的事情。。更改地址，或者设置里面的请求头。。
    //    NSLog(@"----origin request url = %@",request.URL.absoluteString);
    
    return mutableReqeust;
    
}


- (void)startLoading
{
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //做下标记，防止递归调用
    [NSURLProtocol setProperty:@YES forKey:hasInitKey inRequest:mutableReqeust];
    
    NSArray *typeArr = @[@"js", @"img", @"css"];
    for (NSString *typeStr in typeArr) {
        NSString *jsRegex = [HybridPreLoading addLocalFileReturnRex:typeStr];
        [HybridPreLoading rexString:self.request.URL.path rex:jsRegex success:^(NSString *matchStr) {
            setWeakSelf;
            [weakSelf setupAllFile:typeStr];
        } faild:^{
            [NSURLProtocol setProperty:@YES forKey:hasInitKey inRequest:mutableReqeust];
            self.connection = [NSURLConnection connectionWithRequest:mutableReqeust delegate:self];
        }];
    }
    
}




#pragma mark - 根据不同的加载类型加载不同的文件夹，如js、css
-(BOOL)setupAllFile:(NSString *)mimeType
{
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //做下标记，防止递归调用
    [NSURLProtocol setProperty:@YES forKey:hasInitKey inRequest:mutableReqeust];
    
    NSString *rex = [HybridPreLoading addLocalFileReturnRex:mimeType];
    
    setWeakSelf;
    return [HybridPreLoading rexString:self.request.URL.relativePath rex:rex success:^(NSString *matchStr) {
        NSArray *arr = [matchStr componentsSeparatedByString:@"/"];
        NSString *fileName = [arr lastObject];
        NSString *comStr = [@"." stringByAppendingString:mimeType];
        arr = [fileName componentsSeparatedByString:comStr];
        NSString *firstName = [arr firstObject];
        [weakSelf addFiledToClient:firstName MIMEType:mimeType];
    } faild:nil];
}



#pragma mark - 将html请求的css和js的URL替换成本地的，优化加载速度
-(void)addFiledToClient:(NSString *)fileName MIMEType:(NSString *)MIMEType
{
    NSURLResponse *response;
    NSData *data;
    NSString *fileMimeType = MIMEType;
    NSString *Path;
    
    if ([MIMEType isEqualToString:@"css"]) {
        fileMimeType = @"text/css";
        
        //url: www/css/xxx.css
        Path = [NSString stringWithFormat:@"www/%@/%@",MIMEType,fileName];
    }
    
    if ([MIMEType isEqualToString:@"js"]) {
        fileMimeType = @"application/x-javascript";
        
        //url: www/js/xxx.js
        Path = [NSString stringWithFormat:@"www/%@/%@",MIMEType,fileName];
    }
    
    if ([MIMEType isEqualToString:@"img"]) {
        NSArray *arr = [fileName componentsSeparatedByString:@"."];
        NSString *firstName = [arr firstObject];
        NSString *lastName = [arr lastObject];
        fileMimeType = [@"image/" stringByAppendingString:lastName];
        
        //url: www/img/xxx.png|jpg|jpeg|gif
        Path = [NSString stringWithFormat:@"www/%@/%@",MIMEType,firstName];
        MIMEType = lastName;
    }
    
    
    NSString *complexPath = [[NSBundle mainBundle] pathForResource:Path ofType:MIMEType];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    data = [fileManager contentsAtPath:complexPath];
    
    
    response = [[NSURLResponse alloc] initWithURL:self.request.URL
                                         MIMEType:fileMimeType
                            expectedContentLength:data.length
                                 textEncodingName:nil];
    
    
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}


- (void)stopLoading
{
    [self.connection cancel];
}

#pragma mark- NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.client URLProtocol:self didFailWithError:error];
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [[NSMutableData alloc] init];
    self.HTTPResponse = (NSHTTPURLResponse *)response;
    
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}



#pragma mark 正则匹配返回一个（单个）匹配的字符串
+(BOOL)rexString:(NSString *)string rex:(NSString *)rex success:(void (^)(NSString *matchStr))success faild:(void (^)())faild
{
    NSString *searchText = string;
    NSError *error = NULL;
    
    if (string.length == 0) {
        if (faild != nil) {
            faild();
        }
        
        return NO;
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:rex options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    
    NSArray *arr = [regex matchesInString:searchText options:0 range:NSMakeRange(0, searchText.length)];
    
    if (arr.count == 0) {
        if (faild != nil) {
            faild();
        }
        
        return NO;
    } else {
        if (success != nil) {
            success([searchText substringWithRange:result.range]);
        }
        
        return YES;
    }
}


#pragma mark - 遍历www文件夹获取文件名（返回文件名数组）
+(NSArray *)addLocalFile:(NSString *)folderName
{
    NSString *path = [[NSBundle mainBundle] resourcePath];
    path = [path stringByAppendingFormat:@"/www/%@",folderName];
    
    NSFileManager *myFileManager=[NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator = [myFileManager enumeratorAtPath:path];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    while((path=[myDirectoryEnumerator nextObject])!=nil)
    {
        [arr addObject:path];
    }
    
    return arr;
}

#pragma mark - 遍历www文件夹获取文件名，并加入正则参数匹配符合的文件后缀（返回正则字符串）
+(NSString *)addLocalFileReturnRex:(NSString *)folderName{
    NSString *path = [[[NSBundle mainBundle] resourcePath]  stringByAppendingFormat:@"/www/%@",folderName];
    NSFileManager *myFileManager=[NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator = [myFileManager enumeratorAtPath:path];
    NSMutableArray *arr = [NSMutableArray array];
    NSString *regex = @"";
    while((path=[myDirectoryEnumerator nextObject])!=nil)
    {
        [arr addObject:path];
    }
    
    for (int i=0; i<arr.count; i++) {
        NSString *fileName = arr[i];
        regex = [regex stringByAppendingFormat:@".*/%@",fileName];
        if (i != arr.count-1) {
            regex = [regex stringByAppendingString:@"|"];
        }
    }
    
    return regex;
}


@end
