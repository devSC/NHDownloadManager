//
//  NHFileCache.m
//  NHFileDownloadManager-demo
//
//  Created by Wilson Yuan on 15/11/19.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHFileCache.h"
#import <YYCache.h>
#import "NHFileManager.h"
#import "NSString+MD5.h"
//audio
#import "NHAudioConverter.h"
#import "NHAudioTool.h"


@interface NHFileCache ()

@property (strong, nonatomic) YYKVStorage *kvStorage;
@property (strong, nonatomic) YYMemoryCache *memoryCache;
@property (strong, nonatomic) NHAudioTool *audioTool;


@end

//static NSString const *NHFileKVStorageName =;

static dispatch_queue_t _cacheQueue;
char *kNHFileCacheQueue = "com.being.NHFileCache";

@implementation NHFileCache
SingletonImplementationWithClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cacheQueue = dispatch_queue_create(kNHFileCacheQueue, NULL);
    }
    return self;
}

- (void)queryCacheForKey:(NSString *)key done:(void(^)(NSDictionary *fileInfo))doneBlock {
    if (!doneBlock || !key) {
        doneBlock(nil);
        return;
    }
    
    dispatch_async(_cacheQueue, ^{
        //首先检查MemoryCache
        NSDictionary *fileInfo = [self _objectForKey:key];
        if (!fileInfo)  {
            //查看Storage目录有木有记录文件的信息
//            NSData *itemValue = [self.kvStorage getItemValueForKey:key];;
            YYKVStorageItem *item = [self.kvStorage getItemForKey:key];
            if (item) {
                //如果value存在
                fileInfo = [NSKeyedUnarchiver unarchiveObjectWithData:item.value];
                if (fileInfo) {
                    [self.memoryCache setObject:fileInfo forKey:key];
                }
            }
            else {
                //扫描文件夹
                //1.获得文件夹
                NSString *uidString = [NHFileManager chatDirectoryPathForUid:@"99"];
                //2.拼文件名
                NSString *filePath = [uidString stringByAppendingPathComponent:[key md5]];
                //3.判断文件是否存在
                //
                NSString *audioPath = [filePath stringByAppendingPathExtension:@"wav"];
                if ([NHFileManager existsItemAtPath:audioPath]) {
                    //存在文件, 则组织信息
                    fileInfo = [self _wavFileInfoAtFilePath:audioPath];
                    [self cacheObject:fileInfo forKey:key];
                }
                else {
                    NSString *videoPath = [filePath stringByAppendingPathExtension:@"mp4"];
                    if ([NHFileManager existsItemAtPath:videoPath]) {
                        
                        fileInfo = @{NHFilePath : [NHFileManager exceptDocumentPath:videoPath],
                                     NHFileName : [videoPath lastPathComponent]};
                        [self cacheObject:fileInfo forKey:key];
                    }
                }
            }
        }
        doneBlock(fileInfo);
    });
}

//处理文件信息. 如果是音频, 则转码, 然后.返回对应的转码后的地址信息
- (void)fileInfoAtPath:(NSString *)filePath cacheForKey:(NSString *)key done:(void(^)(NSDictionary *info))doneBlock {
    
    dispatch_async(_cacheQueue, ^{
        NSString *fileDirectoryPath = [NHFileManager exceptDocumentPath:filePath];
        if (!fileDirectoryPath) {
            doneBlock(nil);
            return;
        }
        //取后缀
        NSString *pathExtension = [filePath pathExtension];
        NSDictionary *fileInfo = nil;
        //查看是否为音频
        if ([pathExtension isEqualToString:@"amr"]) {
            //这里需要转格式
            NSString *wavPath = [filePath stringByReplacingOccurrencesOfString:@".amr" withString:@".wav"];
            if ([NHAudioConverter convertAmrToWavWithAmrPath:filePath wavSavePath:wavPath]) {
                //获得wav的地址信息
                fileInfo = [self _wavFileInfoAtFilePath:wavPath];
            }
        }
        else {
            fileInfo = @{NHFilePath : fileDirectoryPath,
                         NHFileName : [filePath lastPathComponent]};
        }
        
        //保存转格式后的地址
        [self cacheObject:fileInfo forKey:key];
        doneBlock(fileInfo);
    });
}


- (id)objectForKey:(id)key {
    if (!key) {
        return nil;
    }
    //get memory cache
    id value = [self _objectForKey:key];
    if (!value) {
        value = [self.kvStorage getItemValueForKey:key];
    }
    return value;
}

- (void)cacheObject:(id<NSCoding>)object forKey:(id)key {
#if DEBUG
    NSAssert(object, @"cache object can't be nil");
    NSAssert(object, @"cache object can't be nil");
#endif
    if (!object || !key) {
        return;
    }
    
    [self.memoryCache setObject:object forKey:key];
    if (![self.kvStorage saveItemWithKey:key value:[NSKeyedArchiver archivedDataWithRootObject:object] filename:@"2223" extendedData:nil]) {
        NSLog(@"###warning----- NHFileCache cache failed, key:%@ object:%@", key, object);
    };
}


#pragma mark - Pravite methpd
- (NSDictionary *)_wavFileInfoAtFilePath:(NSString *)filePath {
    NSMutableDictionary *fileInfo = [NSMutableDictionary dictionaryWithDictionary:[self.audioTool audioFileInfoByfilePath:filePath fileType:NHAudioFileTypeWAV]];
    [fileInfo setObject:[NHFileManager exceptDocumentPath:filePath] forKey:@"wavFilePath"];
    return fileInfo;
}

- (id)_objectForKey:(id)key {
    return [self.memoryCache objectForKey:key];
}

#pragma mark - Getter

- (NHAudioTool *)audioTool {
    if (!_audioTool) {
        _audioTool = [[NHAudioTool alloc] init];
    }
    return _audioTool;
}

- (YYMemoryCache *)memoryCache {
    if (!_memoryCache) {
        _memoryCache = [[YYMemoryCache alloc] init];
    }
    return _memoryCache;
}

- (YYKVStorage *)kvStorage {
    if (!_kvStorage) {
        _kvStorage = [[YYKVStorage alloc] initWithPath:[[NHFileManager documentPath] stringByAppendingPathComponent:@"KVSTORAGE"] type:YYKVStorageTypeSQLite];
    }
    return _kvStorage;
}


@end
