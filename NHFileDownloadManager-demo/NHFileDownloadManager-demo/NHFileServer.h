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
SingletonDeclarationWithClass

- (void)server_fileInfoWithUrlString:(NSString *)urlString
                            progress:(ProgressBlock)progressHandler
                             success:(ServerSuccessBlock)successHandler
                             failure:(FailureBlock)failureHandler;

@end
