//
//  NHFileDownloadManager.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileDownloadManager.h"
#import "NHFileDownloadSession.h"

@implementation NHFileDownloadManager
{
    NHFileDownloadSession *session;
}
SingletonImplementationWithClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        
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
    
    session = [[NHFileDownloadSession alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    //获得地址
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    [session downloadFileWithRequest:request distinationUrl:documentsDirectoryURL progress:progressHandler completion:successHandler failure:failureHandler];
    
    [session resume];
    
    return session;
}


@end
