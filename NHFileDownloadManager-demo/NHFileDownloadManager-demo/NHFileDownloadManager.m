//
//  NHFileDownloadManager.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileDownloadManager.h"
#import "NHFileDownloadSession.h"
#import "NHFileManager.h"

#import <YYCache.h>


@interface NHFileDownloadManager ()

@property (strong, nonatomic) NSMutableArray *downLoadTasks;


@end

@implementation NHFileDownloadManager

SingletonImplementationWithClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.downLoadTasks = [NSMutableArray array];
    }
    return self;
}
//如果未存在, 则要下载
- (NHFileDownloadSession *)downloadWithUrlStirng:(NSString *)string
                                          progress:(ProgressBlock)progressHandler
                                           success:(SuccessBlock)successHandler
                                           failure:(FailureBlock)failureHandler {
    if (!string) {
        return nil;
    }
    NHFileDownloadSession *session = [[NHFileDownloadSession alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    
    //文件路径
    NSURL *url = [NSURL fileURLWithPath:[NHFileManager chatDirectoryPathForUid:@"99"]];
    
    //下载成功后, 需不需要做转码
    [session downloadFileWithRequest:request distinationUrl:url progress:progressHandler completion:^(NSURL *fileUrl) {
        successHandler(fileUrl);
        [self.downLoadTasks removeObject:session];
        
    } failure:failureHandler];
    
    [self.downLoadTasks addObject:session];
    
    return session;
}

@end
