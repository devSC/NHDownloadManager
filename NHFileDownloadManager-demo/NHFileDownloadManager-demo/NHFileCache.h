//
//  NHFileCache.h
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/19.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NHFileDownloadHeader.h"

@interface NHFileCache : NSObject
SingletonDeclarationWithClass

- (void)queryDiskCacheForKey:(NSString *)key done:(void(^)(NSDictionary *fileInfo))doneBlock;

- (void)cacheObject:(id)object forKey:(id)key;

- (NSDictionary *)dealFileWithFilePath:(NSString *)filePath;

@end
