//
//  NHFileDownloadOperation.h
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFURLSessionManager.h>

typedef void (^ProgressBlock) (CGFloat progress);
typedef void (^CompletionBlock) (NSURL *fileUrl);
typedef void (^FailureBlock) (NSError *error);

@interface NHFileDownloadOperation : NSOperation

@property (strong, readonly, nonatomic) NSURLResponse *response;

@property (strong, readonly, nonatomic) NSURLRequest *urlRequest;

@property (strong, readonly, nonatomic) NSURLSessionConfiguration *configuration;

@property (strong, readonly, nonatomic) AFURLSessionManager *manager;

@property (strong, readonly, nonatomic) NSProgress *progress;

@property (strong, readonly, nonatomic) NSURLSessionDownloadTask *downloadTask;


- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration;


- (NSURLSessionDownloadTask *)downloadFileWithRequest:(NSURLRequest *)requset
                                       distinationUrl:(NSURL *)path
                                             progress:(ProgressBlock)progressHandler
                                           completion:(CompletionBlock)completionHanlder
                                              failure:(FailureBlock)failureHandler;
@end
