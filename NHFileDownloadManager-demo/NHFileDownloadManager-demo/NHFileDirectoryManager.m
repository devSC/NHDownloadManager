//
//  NHFileDirectoryManager.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/18.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileDirectoryManager.h"
#import <FCFileManager.h>

static NSString *kNHFileManagerChatDirectoryName = @"Chat";
static NSString *kTempUID = @"89229";

@implementation NHFileDirectoryManager


//可以获得各个文件存放的文件夹的目录
+ (NSString *)chatDirectoryPathForUid:(NSString *)uid {
    //uid
    NSString *pathComponent = [[self uidDirectoryByUid:uid] stringByAppendingPathComponent:kNHFileManagerChatDirectoryName];
    
//    NSString *chatDirectory = [FCFileManager pathForDocumentsDirectoryWithPath:pathComponent];
    if (![FCFileManager existsItemAtPath:pathComponent] ) {
        NSError *error;
        if ([[NSFileManager defaultManager] createDirectoryAtPath:pathComponent withIntermediateDirectories:YES attributes:nil error:&error] && !error) {
//        if ([FCFileManager createDirectoriesForFileAtPath:chatDirectory] && !error) {
            NSLog(@"success");
        }
        else {
            NSLog(@"chatDirectoryPathForUid: %@", error.description);
        }
    }
    return pathComponent;
}

+ (NSString *)uidDirectoryByUid:(NSString *)uid {
    NSString *chatDirectory = [FCFileManager pathForDocumentsDirectoryWithPath:uid];
    if (![FCFileManager existsItemAtPath:chatDirectory]) {
        NSError *error;
        if ([FCFileManager createDirectoriesForPath:chatDirectory error:&error] && !error) {
            NSLog(@"success created uid string");
        }
        else {
            NSLog(@"failure created uid string");
        }
    }
    return chatDirectory;
}
@end
