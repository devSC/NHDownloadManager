//
//  ViewController.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <AFDownloadRequestOperation.h>
#import <FCFileManager.h>
//http://img.zcool.cn/community/01d9a8564a94b632f87512f6a7f436.jpg
//@"http://115.238.175.14/music.qqvideo.tc.qq.com/e001845yise.mp4?type=mp4&fmt=mp4&vkey=C62C8F4593AEBCB8252C53B9852DF5D5A97A4D98316A41610517283564F4A3B975970AEE10A13C318F420C9026A9F99A07BE06E56EFA0C92D5D5A3272C1CF24C54604F6BB98ED8533AA18AA03176B939EB05C19B98BE15EB"
static NSString *imageUrlString = @"http://img.zcool.cn/community/01d9a8564a94b632f87512f6a7f436.jpg";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
//    NSString *filePath = [FCFileManager pathForApplicationSupportDirectoryWithPath:@"ss.mp4"];
//    NSString *filePath = [FCFileManager pathForApplicationSupportDirectoryWithPath:@"ss.mp4"];
//    
//    AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:filePath shouldResume:NO];
//    
//    [operation setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
//        NSLog(@"----------/nbytesRead: %ld, totalBytesRead: %lld, /n totalBytesExpected: %lld, totalBytesExpectedToReadForFile: %lld, /n", (long)bytesRead, totalBytesRead, totalBytesExpected, totalBytesExpectedToReadForFile);
//        NSLog(@"%f \n", @(@(totalBytesRead).floatValue / @(totalBytesExpected).floatValue).floatValue);
//    }];
//    [operation start];
//    
//    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        
//    }];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        [responseObject suggestedFilename];
//        
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        
//    }];
    
    NSLog(@"%@", progress);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"%@", change);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
