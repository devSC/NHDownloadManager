//
//  ViewController.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "ViewController.h"
//#import "NHFileDownloadManager.h"
#import "NHFileServer.h"
#import <FCFileManager.h>
#import <YYCache.h>

//http://img.zcool.cn/community/01d9a8564a94b632f87512f6a7f436.jpg
//@"http://115.238.175.14/music.qqvideo.tc.qq.com/e001845yise.mp4?type=mp4&fmt=mp4&vkey=C62C8F4593AEBCB8252C53B9852DF5D5A97A4D98316A41610517283564F4A3B975970AEE10A13C318F420C9026A9F99A07BE06E56EFA0C92D5D5A3272C1CF24C54604F6BB98ED8533AA18AA03176B939EB05C19B98BE15EB"
//amr: http://7xo0ke.com2.z0.glb.qiniucdn.com/FklhfJea-Qv1NOzk939JuXlVg8Rh
//video: http://7xo0ke.com2.z0.glb.qiniucdn.com/Ftwh7N_M0OgZeTEIz3vc8u3D3DNR
static NSString *armUrl = @"http://7xo0ke.com2.z0.glb.qiniucdn.com/FklhfJea-Qv1NOzk939JuXlVg8Rh";
static NSString *videoUrl = @"http://7xo0ke.com2.z0.glb.qiniucdn.com/Ftwh7N_M0OgZeTEIz3vc8u3D3DNR";
static NSString *imageUrlString = @"http://7xo0ke.com2.z0.glb.qiniucdn.com/FklhfJea-Qv1NOzk939JuXlVg8Rh";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    YYMemoryCache *cache = [[YYMemoryCache alloc] init];
//    cache.name = @"sss";
//    
//    if (![cache objectForKey:@"2"]) {
//        [cache setObject:@"1" forKey:@"2"];
//    }
//    else {
//        NSLog(@"%@", [cache objectForKey:@"2"]);
//    }
    
    NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
    basePath = [basePath stringByAppendingPathComponent:@"FileCacheBenchmarkSmall"];
    
    YYKVStorage *yykvFile = [[YYKVStorage alloc] initWithPath:[basePath stringByAppendingPathComponent:@"yykvFile"] type:YYKVStorageTypeFile];
    YYKVStorageItem *item = [yykvFile getItemForKey:@"2"];
    if (item) {
        NSLog(@"%@", item.key);
    }
    else {
        item = [[YYKVStorageItem alloc] init];
        item.key = @"2";
        item.value = [@"1" dataUsingEncoding:NSUTF8StringEncoding];;
//        [yykvFile saveItem:item];
        [yykvFile saveItemWithKey:@"2" value:[@"1" dataUsingEncoding:NSUTF8StringEncoding] filename:@"2" extendedData:nil];
    }
    
    
    [self startToDownloadFile:videoUrl];
}
- (IBAction)downloadAmr:(id)sender {
    [self startToDownloadFile:armUrl];
}
- (IBAction)download:(id)sender {
    [self startToDownloadFile:videoUrl];
    
}

- (void)startToDownloadFile:(NSString *)urlString {
    [NHFileServer server_fileInfoWithUrlString:urlString progress:^(float progress) {
        NSLog(@"---%f", progress);
    } success:^(NSDictionary *fileInfo) {
        NSLog(@"%@", fileInfo);
    } failure:^(NSError *error) {
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
