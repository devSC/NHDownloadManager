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

@interface NSFileServer : NSObject

- (void)server_fileInfoWithUrlString:(NSString *)urlString;
//- (BOOL)file_isExistAtPath:(NSString *)path otherwiseWillDownload:(n):;

@end
