//
//  NHFileDownloadManager.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileDownloadManager.h"
#import "NHFileDownloadSession.h"
#import "NHFileDirectoryManager.h"

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
    NSURL *url = [NSURL fileURLWithPath:[NHFileDirectoryManager chatDirectoryPathForUid:@"99"]];
    
    //下载成功后, 需不需要做转码
    [session downloadFileWithRequest:request distinationUrl:url progress:progressHandler completion:^(NSURL *fileUrl) {
        successHandler(fileUrl);
        [self dealFileWithFilePath:fileUrl.path];
        [self.downLoadTasks removeObject:session];
        
    } failure:failureHandler];
    
    [self.downLoadTasks addObject:session];
    
    return session;
}

//处理文件信息. 如果是音频, 则转码, 然后.返回对应的转码后的地址
- (void)dealFileWithFilePath:(NSString *)filePath {
    
    //取后缀
    NSString *pathExtension = [filePath pathExtension];
    //查看是否为音频
    if (![pathExtension isEqualToString:@"amr"]) {
        return;
    }
    else {
        
    }
    
    //
    
    //取到文件
    NSDictionary *fileAttribuate = [NHFileDirectoryManager attribuateOfItemAtPath:filePath];
    //查看文件后缀
    NSLog(@"%@", fileAttribuate);
    //如果是音频, 然后就处理转码 ->然后返回对应的地址
    //
}

@end
