//
//  NSFileServer.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/19.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileServer.h"

#import "NHFileDownloadManager.h"

#import "NHFileManager.h"


#import "NHAudioConverter.h"

#import "NHFileCache.h"

#import <YYCache.h>


@interface NHFileServer ()

@property (strong, nonatomic) NHFileCache *cache;

@end

@implementation NHFileServer

SingletonImplementationWithClass


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cache = [[NHFileCache alloc] init];
    }
    return self;
}

- (void)server_fileInfoWithUrlString:(NSString *)urlString
                            progress:(ProgressBlock)progressHandler
                             success:(ServerSuccessBlock)successHandler
                             failure:(FailureBlock)failureHandler {
    
    [self.cache queryCacheForKey:urlString done:^(NSDictionary *fileInfo) {
        if (fileInfo) {
            dispatch_async(dispatch_get_main_queue(), ^{
                progressHandler(1.0);
                successHandler(fileInfo);
            });
        }
        else {
            [kNHFileDownloadManager downloadWithUrlStirng:urlString progress:progressHandler success:^(NSURL *fileUrl) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    successHandler([self.cache dealFileAtPath:fileUrl.path cacheForKey:urlString]);
                });
            } failure:failureHandler];
        }
    }];
}

@end
