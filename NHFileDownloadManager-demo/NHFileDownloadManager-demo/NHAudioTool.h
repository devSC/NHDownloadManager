//
//  NHAudioTool.h
//  NHInputView
//
//  Created by Wilson Yuan on 15/11/12.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NHAudioFileType) {
    NHAudioFileTypeAmr,
    NHAudioFileTypeWAV,
};

@class NHAudioTool;
@protocol NHAudioToolDelegate <NSObject>

@optional;
#pragma mark - AVAudioRecord
- (void)audioToolDidStartToRecord;

- (void)audioTool:(NHAudioTool *)tool didUpdateVoiceVolume:(NSInteger)volume;

- (void)audioTool:(NHAudioTool *)tool didEndToRecordWithRecordInfo:(NSDictionary *)info;

- (void)audioTool:(NHAudioTool *)tool didFailedOnRecord:(NSError *)error;

- (void)audioToolDidFailedBecauseTheDurtaionWasToShort;


#pragma mark - AVAudioPlayer
- (void)audioTool:(NHAudioTool *)tool startToPlayAudioFile:(NSString *)filePath;

- (void)audioTool:(NHAudioTool *)tool didSuccessPlayedFile:(NSString *)filePath;

- (void)audioTool:(NHAudioTool *)tool didFailedOnPlayAudioFile:(NSString *)filePath error:(NSError *)error;

@end

@interface NHAudioTool : NSObject

@property (weak, nonatomic) id<NHAudioToolDelegate> delegate;

@property (assign, nonatomic) NSTimeInterval minTimeInteverForRecord; //For recorder最小录音时间 default is 1

- (void)playAudioWithFilePath:(NSString *)filePath;

- (void)startToRecord;

- (void)pauseToRecord;

- (void)stopRecord;

- (void)discardCurrentRecord;

- (NSDictionary *)audioFileInfoByfilePath:(NSString *)filePath fileType:(NHAudioFileType)type;
@end

