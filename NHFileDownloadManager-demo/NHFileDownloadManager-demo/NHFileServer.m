//
//  NSFileServer.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/19.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NSFileServer.h"

#import "NHFileDownloadManager.h"

#import <YYKVStorage.h>

@interface nhfiles : <#superclass#>

@end

@implementation NSFileServer

- (void)server_fileInfoWithUrlString:(NSString *)urlString {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
    //0.检查文件是否下载过,
    
    //1.检查文件是否存在
    
    //2.不存在就下载,并且返回下载信息
    
    //3.下载完成后,保存下载信息
    
}

@end
