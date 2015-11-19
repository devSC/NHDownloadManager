//
//  NHFileDirectoryManager.h
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/18.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHFileDirectoryManager : NSObject


+ (NSString *)uidDirectoryPathByUid:(NSString *)uid;

+ (NSString *)chatDirectoryPathForUid:(NSString *)uid;

+ (NSDictionary *)attribuateOfItemAtPath:(NSString *)path;

@end
