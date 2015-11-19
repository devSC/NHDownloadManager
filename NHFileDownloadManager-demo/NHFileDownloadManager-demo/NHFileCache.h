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

/**
 *  获得缓存信息
 *
 *  @param key       <#key description#>
 *  @param doneBlock <#doneBlock description#>
 */
- (void)queryCacheForKey:(NSString *)key done:(void(^)(NSDictionary *fileInfo))doneBlock;

- (void)cacheObject:(id<NSCoding>)object forKey:(id)key;

- (id)objectForKey:(id)key;

- (NSDictionary *)dealFileAtPath:(NSString *)filePath cacheForKey:(NSString *)key;

@end
