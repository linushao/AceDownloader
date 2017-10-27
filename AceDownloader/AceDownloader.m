//
//  AceDownloader.m
//  AceDownloader
//
//  Created by AceWei on 2017/10/26.
//  Copyright © 2017年 AceWei. All rights reserved.
//

#import "AceDownloader.h"
#import <AFNetworking.h>
#import <YYCategories.h>

@interface AceDownloader ()

/** AFNetworking断点下载（支持离线）需用到的属性 **********/
/** 文件的总长度 */
@property (nonatomic, assign) NSInteger fileLength;
/** 当前下载长度 */
@property (nonatomic, assign) NSInteger currentLength;
/** 文件句柄对象 */
@property (nonatomic, strong) NSFileHandle *fileHandle;

/** 下载任务 */
@property (nonatomic, strong) NSURLSessionDataTask *downloadTask;
/* AFURLSessionManager */
@property (nonatomic, strong) AFURLSessionManager *manager;

@end

@implementation AceDownloader

singleton_implementation(AceDownloader)

- (void)createDownloadWithURL:(NSString *)url
{
//    [self test:123];
    
    [self download:url];
}


#if 0
- (void)test:(NSInteger)vid
{
    NSTimeInterval date = [[NSDate date] timeIntervalSince1970];
    //v_hash = '%d:%d:net.fanship.iSafePlay.avgl3' % (vid, ts)
    
    NSString *v_hash = [NSString stringWithFormat:@"%ld:%.0f:net.fanship.iSafePlay.avgl3", vid,date];
    
    v_hash = [v_hash md5String];
    v_hash = [v_hash base64EncodedString];
    
    NSLog(v_hash);
}
#endif

#if 1
- (void)download:(NSString *)url
{
    
    //    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    //
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    //    [manager downloadTaskWithRequest:request
    //                            progress:^(NSProgress * _Nonnull downloadProgress) {
    //                                //下载进度
    //                                NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    //                            }
    //                         destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
    //                             //保存的文件路径
    //                             NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
    //                             return [NSURL fileURLWithPath:fullPath];
    //                         }
    //                   completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
    //                       NSLog(@"%@",filePath);
    //                   }];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 1. 创建会话管理者
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    // 2. 创建下载路径和请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 3.创建下载任务
    /**
     * 第一个参数 - request：请求对象
     * 第二个参数 - progress：下载进度block
     *      其中： downloadProgress.completedUnitCount：已经完成的大小
     *            downloadProgress.totalUnitCount：文件的总大小
     * 第三个参数 - destination：自动完成文件剪切操作
     *      其中： 返回值:该文件应该被剪切到哪里
     *            targetPath：临时路径 tmp NSURL
     *            response：响应头
     * 第四个参数 - completionHandler：下载完成回调
     *      其中： filePath：真实路径 == 第三个参数的返回值
     *            error:错误信息
     */
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
        // 下载进度
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *path = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [path URLByAppendingPathComponent:response.suggestedFilename];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    
    // 4. 开启下载任务
    [downloadTask resume];
    
    
    
//    [downloadTask suspend];
}
#endif




/**
 * 获取已下载的文件大小
 */
- (NSInteger)fileLengthForPath:(NSString *)path {
    NSInteger fileLength = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileLength = [fileDict fileSize];
        }
    }
    return fileLength;
}

@end
