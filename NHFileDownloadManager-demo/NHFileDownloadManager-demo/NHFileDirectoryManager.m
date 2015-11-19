//
//  NHFileDirectoryManager.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/18.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileDirectoryManager.h"
#import <FCFileManager.h>

static NSString *kNHFileManagerChatDirectoryName = @"Chat/";
static NSString *kTempUID = @"89229";

@implementation NHFileDirectoryManager


//可以获得各个文件存放的文件夹的目录
+ (NSString *)chatDirectoryPathForUid:(NSString *)uid {
    //uid
    NSString *pathComponent = [[self uidDirectoryPathByUid:uid] stringByAppendingPathComponent:kNHFileManagerChatDirectoryName];
    
    if (![FCFileManager existsItemAtPath:pathComponent] ) {
        NSError *error;
        if ([FCFileManager createDirectoriesForPath:pathComponent error:&error] && !error) {
            NSLog(@"success created chat directory");
        }
        else {
            NSLog(@"chatDirectoryPathForUid: %@", error.description);
        }
    }
    return pathComponent;
}

+ (NSString *)uidDirectoryPathByUid:(NSString *)uid {
    NSString *chatDirectory = [FCFileManager pathForDocumentsDirectoryWithPath:uid];
    if (![FCFileManager existsItemAtPath:chatDirectory]) {
        NSError *error;
        if ([FCFileManager createDirectoriesForPath:chatDirectory error:&error] && !error) {
            NSLog(@"success created uid directory path");
        }
        else {
            NSLog(@"failure created uid directory path");
        }
    }
    return chatDirectory;
}


+ (NSDictionary *)attribuateOfItemAtPath:(NSString *)path {
    NSError *error;
    NSDictionary *attribuate = [FCFileManager attributesOfItemAtPath:path error:&error];
    if (error) {
        NSLog(@"%s, %@",__FUNCTION__, error.description);
    }
    return attribuate;
}
@end
