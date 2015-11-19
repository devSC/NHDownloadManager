//
//  NHFileCache.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/19.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileCache.h"
#import <YYCache.h>
#import "NHFileDirectoryManager.h"
#import "NSString+MD5.h"
//audio
#import "NHAudioConverter.h"
#import "NHAudioTool.h"


@interface NHFileCache ()

@property (strong, nonatomic) YYKVStorage *kvStorage;
@property (strong, nonatomic) YYMemoryCache *cache;
@property (strong, nonatomic) YYMemoryCache *memoryCache;

@property (strong, nonatomic) NHAudioTool *audioTool;


@end

//static NSString const *NHFileKVStorageName =;
static dispatch_queue_t _cacheQueue;

@implementation NHFileCache
SingletonImplementationWithClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cacheQueue = dispatch_queue_create("com.being.NHFileCache", NULL);
        
        self.audioTool = [[NHAudioTool alloc] init];

    }
    return self;
}

- (void)queryDiskCacheForKey:(NSString *)key done:(void(^)(NSDictionary *fileInfo))doneBlock {
    if (!doneBlock || !key) {
        return;
    }
    //最后返回的filePath
    //video 和 audio
    //首先检查MemoryCache
    
    dispatch_async(_cacheQueue, ^{
        NSDictionary *fileInfo = [self _objectForKey:key];
        
        if (fileInfo) {
            doneBlock(fileInfo);
            return;
        }
        else {
            //查看Storage目录有木有记录文件信息
            YYKVStorageItem *item = [self.kvStorage getItemForKey:key];;
            if (item) {
                //如果value存在    //应该保存的是视频文件的document下的地址
                NSDictionary *value = [NSKeyedUnarchiver unarchiveObjectWithData:item.value];
                if (value) {
                    
                    [self.memoryCache setObject:value forKey:key];
                    
                    doneBlock(value);
                    return;
                }
                else {
                    //扫描文件夹
                    //1.获得文件夹
                    NSString *uidString = [NHFileDirectoryManager uidDirectoryPathByUid:@"99"];
                    //2.拼文件名
                    NSString *filePath = [uidString stringByAppendingPathComponent:[key md5]];
                    //3.判断文件是否存在
                    //
                    NSString *audioPath = [filePath stringByAppendingPathExtension:@".wav"];
                    if ([NHFileDirectoryManager existsItemAtPath:audioPath]) {
                        //存在文件, 则组织信息
                        
                    }
                    else if ([NHFileDirectoryManager existsItemAtPath:@".mp4"]) {
                        //组织mp4信息
                    }
                    else {
                        return;
                    }
                    //文件名是URL转换成的MD5加密字符串
                    //4.不存在则返回nil
                }
            }        
        }
    });
}

- (void)cacheObject:(id)object forKey:(id)key {
    [self.memoryCache setObject:object forKey:key];
    
    [self.kvStorage saveItemWithKey:key value:[NSKeyedArchiver archivedDataWithRootObject:object] filename:key extendedData:nil];
}

//处理文件信息. 如果是音频, 则转码, 然后.返回对应的转码后的地址
- (NSDictionary *)dealFileWithFilePath:(NSString *)filePath {
    
    NSString *fileDirectoryPath = [NHFileDirectoryManager exceptDocumentPath:filePath];
    //    NSLog(@"%@", fileDirectoryPath);
    if (!fileDirectoryPath) {
        return nil;
    }
    
    //取后缀
    NSString *pathExtension = [filePath pathExtension];
    NSMutableDictionary *fileInfo = nil;
    //查看是否为音频
    if ([pathExtension isEqualToString:@"amr"]) {
        //这里需要转格式
        NSString *wavPath = [filePath stringByReplacingOccurrencesOfString:@".amr" withString:@".wav"];
        if ([NHAudioConverter convertAmrToWavWithAmrPath:filePath wavSavePath:wavPath]) {
            
            NSDictionary *wavAudioInfo = [self.audioTool audioFileInfoByfilePath:wavPath fileType:NHAudioFileTypeWAV];;
            fileInfo = [NSMutableDictionary dictionaryWithDictionary:wavAudioInfo];
            [fileInfo setObject:filePath forKey:@"amrFilePath"];
            [fileInfo setObject:wavPath forKey:@"wavFilePath"];
            
            //保存转格式后的地址
            //获得wav的地址信息
            //缓存信息
        }
    }
    else {
        fileInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"filePath" : filePath}];
    }
    
    return fileInfo;
}



- (id)_objectForKey:(id)key {
    return [self.memoryCache objectForKey:key];
}

#pragma mark - value

- (YYMemoryCache *)memoryCache {
    if (!_memoryCache) {
        _memoryCache = [[YYMemoryCache alloc] init];
    }
    return _memoryCache;
}

- (YYKVStorage *)kvStorage {
    if (!_kvStorage) {
        _kvStorage = [[YYKVStorage alloc] initWithPath:[NHFileDirectoryManager documentPath] type:YYKVStorageTypeFile];
    }
    return _kvStorage;
}


@end
