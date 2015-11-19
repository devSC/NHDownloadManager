//
//  NHAudioTool.m
//  NHInputView
//
//  Created by Wilson Yuan on 15/11/12.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHAudioTool.h"
//sys
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
//utils
#import "NHAudioConverter.h"
#import "NSString+UUID.h"
#import "NHAudioTool+Helper.h"

@interface NHAudioTool ()<AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) NSTimer *timer;

@property (copy, nonatomic) NSString *recordFileName;
@property (copy, nonatomic) NSString *recordFilePath;
@property (copy, nonatomic) NSString *playerFilePath;

@property (nonatomic) NSTimeInterval recordDuration;

@end

static NSString *NHAudioToolRecorderFileType = @"wav";

@implementation NHAudioTool
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.minTimeInteverForRecord = 1;
    }
    return self;
}
#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        [self callDelegateDidSuccessedToPlayAudioFileIfCould];
    }
    else {
        [self callDelegateDidFailedToPlayAudioFileIfCouldWithError:nil];
    }
}


- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error {
    [self callDelegateDidFailedToPlayAudioFileIfCouldWithError:error];
}



#pragma mark - Play

- (void)playAudioWithFilePath:(NSString *)filePath
{
    [self setCurrentAudioSessionActiveIfNecessary];
    
    [self stopToPlay];
    
    self.playerFilePath = filePath;
    
    self.audioPlayer = [self audioPlayerWithFilePath:filePath];
    
    [self.audioPlayer prepareToPlay];
    
    [self.audioPlayer play];
    
    [self callDelegateDidStartToPlayAudioFileIfCould];
}

- (void)stopToPlay {
    
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
    }
    self.audioPlayer = nil;
}

#pragma mark - Record
- (void)startToRecord {
    //停止播放
    [self stopToPlay];
    
    if ([self.recorder prepareToRecord]) {
        
        [self setCurrentAudioSessionActiveIfNecessary];
        
        if ([self.delegate respondsToSelector:@selector(audioToolDidStartToRecord)]) {
            [self.delegate audioToolDidStartToRecord];
        }
        
        [self.recorder record];
        [self startToUpdateMeters];
    }
    else if ([self.recorder isRecording]){
        [self.recorder record]; //resume
        [self startToUpdateMeters];
    }
    else {
        NSLog(@"###waring --- failure to resume the record");
    }
}


- (void)stopRecord {
    
    //判断
    if (![self isLargeThanMinTimeInteverForRecorder]) {
        [self callDelegateAudioToolDidFailedBecauseTheDurtaionWasToShort];
        [self discardCurrentRecord];
    }
    else {
        [self stopRecordIfNecessary];
        [self convertWavFileToAmr];
    }
    //
    [self invalidateTimer];
}

- (BOOL)isLargeThanMinTimeInteverForRecorder {
    if (self.recorder.currentTime >= self.minTimeInteverForRecord) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)pauseToRecord {
    if ([self.recorder isRecording]) {
        [self.recorder pause];
    }
    [self invalidateTimer];
}

- (void)discardCurrentRecord {
    
    [self stopRecordIfNecessary];
    //删除文件
    [self removeItemAtPath:self.recordFilePath];
}

- (void)stopRecordIfNecessary {
    if ([self.recorder isRecording]) {
        
        self.recordDuration = self.recorder.currentTime;
        [self.recorder stop];
        [self resetRecorder];
    }
    
    [self callDelegateToUpdateVoiceVolume:0];
    
}

- (void)invalidateTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)startToUpdateMeters {
    
    self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(updateRecordMeters) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}


- (void)updateRecordMeters {
    
    [self.recorder updateMeters];
    
    float peakPower = [self.recorder averagePowerForChannel:0];
    double ALPHA = 0.05;
    double peakPowerForChannel = pow(10, (ALPHA * peakPower));
    CGFloat lowPassResults = MIN(MAX(0.f, peakPowerForChannel), 1.f);
    NSInteger volumn = 0;
    
    if (0<lowPassResults<=0.06) {
        volumn = 0;
    }else if (0.06<lowPassResults<=0.13) {
        volumn = 1;
    }else if (0.13<lowPassResults<=0.20) {
        volumn = 2;
    }else if (0.20<lowPassResults<=0.27) {
        volumn = 3;
    }else if (0.27<lowPassResults<=0.34) {
        volumn = 4;
    }else if (0.34<lowPassResults<=0.41) {
        volumn = 5;
    }else if (0.41<lowPassResults<=0.48) {
        volumn = 6;
    }else if (0.48<lowPassResults<=0.55) {
        volumn = 7;
    }else if (0.55<lowPassResults<=0.62) {
        volumn = 8;
    }else if (0.62<lowPassResults<=0.69) {
        volumn = 9;
    }else if (0.69<lowPassResults<=0.76) {
        volumn = 10;
    }else if (0.76<lowPassResults<=0.83) {
        volumn = 11;
    }else if (0.83<lowPassResults<=0.9) {
        volumn = 12;
    }else {
        volumn = 13;
    }
    
    [self callDelegateToUpdateVoiceVolume:volumn];
}


#pragma mark - File

- (void)convertWavFileToAmr {
    //转换后的path
    NSString *amrPath = [self pathByFileName:self.recordFileName ofType:@"amr"];
    
    if ([NHAudioConverter convertWavToAmrWithWavPath:self.recordFilePath amrSavePath:amrPath]) {
        //Success
        
//        NSTimeInterval duration = [self ]
        //获得信息
        NSDictionary *amrInfo = [self audioFileInfoByfilePath:amrPath fileType:NHAudioFileTypeAmr];
        NSMutableDictionary *fileInfo = [NSMutableDictionary dictionaryWithDictionary:amrInfo];
        [fileInfo setObject:amrPath forKey:@"amrFilePath"];
        [fileInfo setObject:@(@(self.recordDuration).integerValue) forKey:@"amrFileDuration"];
        [fileInfo setObject:self.recordFilePath forKey:@"wavFilePath"];
        [fileInfo setObject:self.recordFileName forKey:@"wavFileName"];
        
        
        if ([self.delegate respondsToSelector:@selector(audioTool:didEndToRecordWithRecordInfo:)]) {
            [self.delegate audioTool:self didEndToRecordWithRecordInfo:fileInfo];
        }
    }
    else {
        if ([self.delegate respondsToSelector:@selector(audioTool:didFailedOnRecord:)]) {
            [self.delegate audioTool:self didFailedOnRecord:nil];
        }
        NSLog(@"#waring------NHAudioConverter convert wav to amr was filed. file path: %@", self.recordFilePath);
    }
}

- (void)resetRecorder {
    self.recorder = nil;
}
#pragma mark - Call method
- (void)callDelegateDidStartToPlayAudioFileIfCould {
    if ([self.delegate respondsToSelector:@selector(audioTool:startToPlayAudioFile:)]) {
        [self.delegate audioTool:self startToPlayAudioFile:self.playerFilePath];
    }
}
- (void)callDelegateDidSuccessedToPlayAudioFileIfCould {
    if ([self.delegate respondsToSelector:@selector(audioTool:didSuccessPlayedFile:)]) {
        [self.delegate audioTool:self didSuccessPlayedFile:self.playerFilePath];
    }
}
- (void)callDelegateDidFailedToPlayAudioFileIfCouldWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(audioTool:didFailedOnPlayAudioFile:error:)]) {
        [self.delegate audioTool:self didFailedOnPlayAudioFile:self.playerFilePath error:error];
    }
}
- (void)callDelegateAudioToolDidFailedBecauseTheDurtaionWasToShort {
    if ([self.delegate respondsToSelector:@selector(audioToolDidFailedBecauseTheDurtaionWasToShort)]) {
        [self.delegate audioToolDidFailedBecauseTheDurtaionWasToShort];
    }
}
- (void)callDelegateToUpdateVoiceVolume:(CGFloat)volumn {
    if ([self.delegate respondsToSelector:@selector(audioTool:didUpdateVoiceVolume:)]) {
        [self.delegate audioTool:self didUpdateVoiceVolume:volumn];
    }
}

- (NSDictionary *)audioFileInfoByfilePath:(NSString *)filePath fileType:(NHAudioFileType)type {
    
    NSUInteger fileSize = [self fileSizeAtPath:filePath] / 1024;
    NSString *fileName = filePath.lastPathComponent;
    
    CGFloat duration;
    //Amr得不到duration
    if ([fileName rangeOfString:@"wav"].length > 0) {
        AVAudioPlayer *player = [self audioPlayerWithFilePath:filePath];
        duration = @(player.duration).floatValue;
    }
    else {
        duration = 0;
    }
    if (duration <= 0) {
        duration = 0;
    }
    if (type == NHAudioFileTypeAmr) {
        return @{@"amrFileSize" : @(fileSize),
                 @"amrFileName" : fileName,
                 @"amrFileDuration" : @(duration)};
    }
    else if (type == NHAudioFileTypeWAV){
        return @{@"wavFileSize" : @(fileSize),
                 @"wavFileName" : fileName,
                 @"wavFileDuration" : @(duration)};

    }
    else {
        return nil;
    }
}

- (void)setCurrentAudioSessionActiveIfNecessary {
    
    NSError *error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    [self printErrorInfomation:error];
    
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    [self printErrorInfomation:error];
    
}
- (void)printErrorInfomation:(NSError *)error {
    if (error) {
        NSLog(@"NHAudioTool Error: %@", error.description);
        error = nil;
    }
}

#pragma mark - Getter
- (AVAudioRecorder *)recorder {
    if (!_recorder) {
        self.recordFileName = [NSString uuidStr];
        self.recordFilePath = [self pathByFileName:self.recordFileName ofType:NHAudioToolRecorderFileType];
        NSError *error;
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:self.recordFilePath] settings:[NHAudioConverter audioRecorderSettingDict] error:&error];
        _recorder.meteringEnabled = YES;
    }
    return _recorder;
}

- (AVAudioPlayer *)audioPlayerWithFilePath:(NSString *)filePath {
    if (!_audioPlayer) {
        
        NSError *error;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:&error];
        _audioPlayer.delegate = self;
        if (error) {
            NSLog(@"playerWithFilePath error: %@", error.description);
        }
    }
    return _audioPlayer;
}
@end
