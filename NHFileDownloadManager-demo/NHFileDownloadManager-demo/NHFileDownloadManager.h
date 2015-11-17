//
//  NHFileDownloadManager.h
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NHFileDownloadHeader.h"


typedef void (^ProgressBlock) (float progress);
typedef void (^SuccessBlock) (NSURL *fileUrl);
typedef void (^FailureBlock) (NSError *error);

@class NHFileDownloadSession;


@interface NHFileDownloadManager : NSObject

SingletonDeclarationWithClass

/**
 *  下载文件方法
 *
 *  @param string          urlString
 *  @param progressHandler 下载文件进度回调
 *  @param successHandler  下载成功回调
 *  @param failureHandler  下载失败回调
 *
 *  @return NHFileDownloadSession instance
 */
- (NHFileDownloadSession *)downloadWithUrlStirng:(NSString *)string
                                        progress:(ProgressBlock)progressHandler
                                         success:(SuccessBlock)successHandler
                                         failure:(FailureBlock)failureHandler;


@end
