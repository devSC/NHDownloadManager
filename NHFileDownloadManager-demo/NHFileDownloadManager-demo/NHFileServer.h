//
//  NSFileServer.h
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/19.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

/**
 *  用来统一管理文件下载
 */
#import <Foundation/Foundation.h>
#import "NHFileDownloadHeader.h"

typedef void (^ServerSuccessBlock) (NSDictionary *fileInfo);

@interface NHFileServer : NSObject
/**
 *  获取文件信息方法
 *  优先检查是否有缓存, 无缓存后, 就会走下载方法
 *  @param urlString       连接地址
 *  @param progressHandler 进度回调
 *  @param successHandler  成功回调
 *  @param failureHandler  失败回调
 */
+ (void)server_fileInfoWithUrlString:(NSString *)urlString
                            progress:(ProgressBlock)progressHandler
                             success:(ServerSuccessBlock)successHandler
                             failure:(FailureBlock)failureHandler;

@end
