//
//  NHFileDownloadHeader.h
//  NHFileDownloadManager-demo
//
//  Created by Wilson-Yuan on 15/11/17.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#ifndef NHFileDownloadHeader_h
#define NHFileDownloadHeader_h

typedef void (^ProgressBlock) (float progress);
typedef void (^SuccessBlock) (NSURL *fileUrl);
typedef void (^FailureBlock) (NSError *error);

static NSString * const NHFilePath = @"NHFilePath";
static NSString * const NHFileName = @"NHFileName";

#define SingletonDeclarationWithClass +(instancetype)sharedInstance;
#define SingletonImplementationWithClass \
+ (instancetype)sharedInstance {\
static id instance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
}



#endif /* NHFileDownloadHeader_h */
