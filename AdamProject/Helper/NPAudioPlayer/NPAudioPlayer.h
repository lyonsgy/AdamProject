//
//  NPAudioPlayer.h
//  Jikebaba
//
//  Created by NPlus on 2016/12/7.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
typedef NS_ENUM(NSUInteger, AudioPlayerStatus) {
    AudioPlayerStatusEnd,            //播放结束
    AudioPlayerStatusUnknown,       //未知状态，此时不能播放
    AudioPlayerStatusReadyToPlay,  //准备完毕，可以播放
    AudioPlayerStatusFailed       //加载失败，网络或者服务器出现问题
};

@protocol NPAudioPlayerDelegate <NSObject>
@optional

/**
 AudioPlayer当前播放时间

 @param currentTime 当前播放时间
 */
- (void)audioPlayerCurrentTime:(NSInteger)currentTime;

/**
 AudioPlayer播放状态

 @param audioPlayerStatus AudioPlayer播放状态
 */
- (void)audioPlayerState:(AudioPlayerStatus)audioPlayerStatus;

@end

@interface NPAudioPlayer : NSObject

@property (nonatomic, strong)AVPlayerItem *songItem;
@property (nonatomic, assign)AudioPlayerStatus audioPlayerStatus;

/** 设置代理 */
@property (nonatomic, weak) id<NPAudioPlayerDelegate>delegate;

- (instancetype)initWithURL:(NSString *)URL;

- (void)resetToPlayNewAudio:(NSString *)URL;
- (void)sliderSeekToTime:(NSInteger)time completionHandler:(void (^)(BOOL finished))completionHandler;
- (void)play;
- (void)pause;
- (void)closePlayer;
@end
