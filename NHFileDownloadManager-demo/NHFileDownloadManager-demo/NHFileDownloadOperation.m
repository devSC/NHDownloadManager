//
//  NHFileDownloadOperation.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileDownloadOperation.h"
@interface NHFileDownloadOperation ()

@property (strong, nonatomic) NSURLRequest *urlRequest;

@property (strong, nonatomic) NSURLSessionConfiguration *configuration;

@property (strong, nonatomic) AFURLSessionManager *manager;

@property (strong, nonatomic) NSURLSessionDownloadTask *downloadTask;

@property (copy, nonatomic) CompletionBlock completionHandler;
@property (copy, nonatomic) FailureBlock failureHandler;
@property (copy, nonatomic) ProgressBlock progressHandler;


@end

static NSString *NHFileDownloadProgressKeyPath = @"fractionCompleted";

@implementation NHFileDownloadOperation

@synthesize urlRequest = _urlRequest;
@synthesize configuration = _configuration;
@synthesize manager = _manager;
@synthesize progress = _progress;
@synthesize downloadTask = _downloadTask;

- (void)dealloc
{
    [self removeObserver:self forKeyPath:NHFileDownloadProgressKeyPath];
}

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
    
    self.progressHandler = [progress copy];
    
    NSURLSessionDownloadTask *downLoadTask = [self.manager downloadTaskWithRequest:requset progress:&progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return path;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error && failureHandler) {
            failureHandler(error);
        }
        else if (completionHanlder) {
            completionHanlder(filePath);
        }
    }];
    
    [progress addObserver:self forKeyPath:NHFileDownloadProgressKeyPath options:NSKeyValueObservingOptionNew context:nil];
    
    return downLoadTask;
}
- (void)resume {
    [self.downloadTask resume];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NHFileDownloadProgressKeyPath] && self.progressHandler) {
        self.progressHandler([change[@"new"] floatValue]);
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
