//
//  NHFileDirectoryManager.h
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/18.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHFileDirectoryManager : NSObject


+ (NSString *)documentPath;

+ (NSString *)uidDirectoryPathByUid:(NSString *)uid;

+ (NSString *)chatDirectoryPathForUid:(NSString *)uid;

+ (NSDictionary *)attribuateOfItemAtPath:(NSString *)path;

/**
 *  得到绝对路径 ->Document/之后的路径
 *
 *  @param path 原路径
 *
 *  @return 绝对路径
 */
+ (NSString *)exceptDocumentPath:(NSString *)path;

/**
 *  拼接上Document路径
 *
 *  @param path 文件夹路径
 *
 *  @return 完成路径
 */
+ (NSString *)appendingDocumentPath:(NSString *)path;

+ (NSString *)pathByFileName:(NSString *)fileName ofType:(NSString *)type;

+ (NSUInteger)fileSizeAtPath:(NSString *)filePath;

+ (BOOL)existsItemAtPath:(NSString *)path;
@end
