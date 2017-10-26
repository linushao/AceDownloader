//
//  HybridPreLoading.h
//  WebViewDemo
//
//  Created by 魏诗豪 on 16/3/13.
//  Copyright © 2016年 魏诗豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HybridPreLoading : NSURLProtocol


@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSHTTPURLResponse *HTTPResponse;


/**
 *  正则匹配返回一个（单个）匹配的字符串
 */
+(BOOL)rexString:(NSString *)string rex:(NSString *)rex success:(void (^)(NSString *matchStr))success faild:(void (^)())faild;


/**
 *  遍历www文件夹获取文件名
 *
 *  @return 返回文件名数组
 */
+(NSArray *)addLocalFile:(NSString *)folderName;


/**
 *  遍历www文件夹获取文件名，并加入正则参数匹配符合的文件后缀（返回正则字符串）
 *
 *  @return 返回正则字符串
 */
+(NSString *)addLocalFileReturnRex:(NSString *)folderName;



@end
