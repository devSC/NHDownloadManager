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


+ (NSString *)documentPath {
    return [FCFileManager pathForDocumentsDirectory];
}
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

+ (NSString *)exceptDocumentPath:(NSString *)path {
    
    NSRange docRange = [path rangeOfString:[self documentPath]];
    //有对应的文件夹
    if (docRange.length != NSNotFound) {
        //得到Document之后的文件地址
        return [path substringFromIndex:docRange.length];
    }
    else {
        return nil;
    }
}

+ (NSString *)appendingDocumentPath:(NSString *)path {
    NSRange docRange = [path rangeOfString:[self documentPath]];
    //有对应的文件夹
    if (docRange.length == NSNotFound) {
        //得到Document之后的文件地址
        return [[self documentPath] stringByAppendingString:path];
    }
    else {
        return nil;
    }
}

//+ (NSString *)pathByFileName:(NSString *)fileName ofType:(NSString *)type {
//    return [self uidDirectoryPathByUid:<#(NSString *)#>]
//}

+ (NSUInteger)fileSizeAtPath:(NSString *)filePath {
    
    if ([FCFileManager existsItemAtPath:filePath]) {
        NSError *error;
        NSDictionary *attributes = [FCFileManager attributesOfItemAtPath:filePath error:&error];
        return [[attributes objectForKey:NSFileSize] integerValue];
    }
    else {
        NSLog(@"File not exists");
        return 0;
    }

}
+ (BOOL)existsItemAtPath:(NSString *)path {
    return [FCFileManager existsItemAtPath:path];
}

@end
