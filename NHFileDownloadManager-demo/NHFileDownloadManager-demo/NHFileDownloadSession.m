//
//  NHFileDownloadOperation.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileDownloadSession.h"
@interface NHFileDownloadSession ()

@property (strong, nonatomic) NSURLRequest *urlRequest;

@property (strong, nonatomic) AFURLSessionManager *manager;

@property (strong, nonatomic) NSURLSessionDownloadTask *downloadTask;

@property (copy, nonatomic) CompletionBlock completionHandler;

@property (copy, nonatomic) FailureBlock failureHandler;

@property (copy, nonatomic) ProgressBlock progressHandler;


@end

static NSString *NHFileDownloadProgressKeyPath = @"fractionCompleted";

@implementation NHFileDownloadSession
- (void)dealloc
{
    
}
@synthesize urlRequest = _urlRequest;
@synthesize manager = _manager;
@synthesize downloadTask = _downloadTask;

- (instancetype)init
{
    return [self initWithSessionConfiguration:nil];
}

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
    self = [super init];
    if (!self) {
        return nil;
    }
    if (!configuration) {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    self.manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    return self;
    
}
- (NSURLSessionDownloadTask *)downloadFileWithRequest:(NSURLRequest *)requset
                                       distinationUrl:(NSURL *)path
                                             progress:(ProgressBlock)progressHandler
                                           completion:(CompletionBlock)completionHanlder
                                              failure:(FailureBlock)failureHandler {
    
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:1];
    
    self.progressHandler = [progressHandler copy];
    self.urlRequest = requset;
    
//    __weak typeof(self) wSelf = self;
    
    self.downloadTask = [self.manager downloadTaskWithRequest:requset progress:&progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [path URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
//        __strong typeof(wSelf) self = wSelf;
        if (error && failureHandler) {
            failureHandler(error);
        }
        else if (completionHanlder) {
            completionHanlder(filePath);
        }
//        [progress removeObserver:self forKeyPath:NHFileDownloadProgressKeyPath];
    }];
    
    [self.downloadTask resume];
    
    [progress addObserver:self forKeyPath:NHFileDownloadProgressKeyPath options:NSKeyValueObservingOptionNew context:NULL];

    return self.downloadTask;
}
- (void)resume {
//    [self.downloadTask resume];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if ([keyPath isEqualToString:NHFileDownloadProgressKeyPath] && self.progressHandler) {
        CGFloat progress = [change[@"new"] floatValue];
        self.progressHandler(progress);
        if (progress == 1) {
            @try {
                [object removeObserver:self forKeyPath:NHFileDownloadProgressKeyPath];
            }
            @catch (NSException *exception) {
                NSLog(@"%@", exception);
            }
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

/*
- (void)start {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:@"sss"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:10];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    
    [downloadTask resume];
    
    [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];

}
 */
@end
