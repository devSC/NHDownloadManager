//
//  NHFileDownloadManager.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileDownloadManager.h"
#import "NHFileDownloadSession.h"

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


- (NHFileDownloadSession *)downloadWithUrlStirng:(NSString *)string
                                          progress:(ProgressBlock)progressHandler
                                           success:(SuccessBlock)successHandler
                                           failure:(FailureBlock)failureHandler {
    if (!string) {
        return nil;
    }
    NHFileDownloadSession *session = [[NHFileDownloadSession alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    [session downloadFileWithRequest:request distinationUrl:documentsDirectoryURL progress:progressHandler completion:^(NSURL *fileUrl) {
        successHandler(fileUrl);
        
        [self.downLoadTasks removeObject:session];
        
    } failure:failureHandler];
    
    [self.downLoadTasks addObject:session];
    
    return session;
}


@end
