//
//  ViewController.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "ViewController.h"
#import "NHFileServer.h"

static NSString *armUrl = @"http://7xo0ke.com2.z0.glb.qiniucdn.com/FklhfJea-Qv1NOzk939JuXlVg8Rh";
static NSString *videoUrl = @"http://7xo0ke.com2.z0.glb.qiniucdn.com/Ftwh7N_M0OgZeTEIz3vc8u3D3DNR";
static NSString *imageUrlString = @"http://img.zcool.cn/community/01d9a8564a94b632f87512f6a7f436.jpg";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        NSLog(@"%@", error.description);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
