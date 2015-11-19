//
//  NSFileServer.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/19.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileServer.h"

#import "NHFileDownloadManager.h"

#import "NHFileDirectoryManager.h"


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

    }
    return self;
}



- (void)server_fileInfoWithUrlString:(NSString *)urlString
                            progress:(ProgressBlock)progressHandler
                             success:(ServerSuccessBlock)successHandler
                             failure:(FailureBlock)failureHandler {
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //0.检查文件是否下载过,
//        NSDictionary *cachedInfo = [self.cache objectForKey:urlString];
        //1.检查文件是否存在
//        if ([cachedInfo objectForKey:@"filePath"]) {
//
//        }
        if (1) {
            [kNHFileDownloadManager downloadWithUrlStirng:urlString progress:progressHandler success:^(NSURL *fileUrl) {
                successHandler([self.cache dealFileWithFilePath:fileUrl.path]);
            } failure:^(NSError *error) {
                
            }];
        }
        else {
            //
        }
//    });
    
    
    //2.不存在就下载,并且返回下载信息
    
    //3.下载完成后,保存下载信息
    
}




//- (YYMemoryCache *)cache {
//    if (!_cache) {
//        _cache = [[YYMemoryCache alloc] init];
//    }
//    return _cache;
//}

@end
