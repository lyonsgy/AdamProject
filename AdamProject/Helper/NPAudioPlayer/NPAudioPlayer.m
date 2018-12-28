//
//  NPAudioPlayer.m
//  Jikebaba
//
//  Created by NPlus on 2016/12/7.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import "NPAudioPlayer.h"
@interface NPAudioPlayer()
@property (nonatomic, strong)AVPlayer *player;
@property (nonatomic,strong) id timeObserve;

@end

@implementation NPAudioPlayer
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)URL{
    self = [super init];
    if (self) {
        self.songItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:URL]];
        self.player = [[AVPlayer alloc]initWithPlayerItem:self.songItem];
        [self.player pause];
        //监听播放状态
        [self.songItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        //播放是否结束
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.songItem];
        //监听播放时间
        WS(weakSelf)
        _timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            //播放时间监听
            float current = CMTimeGetSeconds(time);
            if ([weakSelf.delegate respondsToSelector:@selector(audioPlayerCurrentTime:)]) {
                [weakSelf.delegate audioPlayerCurrentTime:current];
            }
        }];
    }
    return self;
}
- (void)resetToPlayNewAudio:(NSString *)URL
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:URL] options:nil];
    
    [self.songItem removeObserver:self forKeyPath:@"status"];
    self.songItem = [AVPlayerItem playerItemWithAsset:asset];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.songItem];
    if (self.player.currentItem) {
        
        [self.player replaceCurrentItemWithPlayerItem:self.songItem];
        
    }else{
        
        self.player = [AVPlayer playerWithPlayerItem:self.songItem];
        
    }
    [self.songItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.player play];
}
-(void)sliderSeekToTime:(NSInteger)time completionHandler:(void (^)(BOOL finished))completionHandler{
    CMTime dragedCMTime = CMTimeMake(time, 1); //kCMTimeZero
    [self.player seekToTime:dragedCMTime toleranceBefore:CMTimeMake(1,1) toleranceAfter:CMTimeMake(1,1) completionHandler:^(BOOL finished) {
        // 视频跳转回调
        [self.player play];
        // 结束滑动
        if (completionHandler) {
            completionHandler(finished);
        }
    }];
}
-(void)dealloc{
    [self closePlayer];
}
#pragma mark - Setter

- (void)play{
    [self.player play];
}

- (void)pause{
    [self.player pause];
}

- (void)closePlayer{
    if (self.timeObserve) {
        [self.player removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
    [self removeVideoNotic];
    [self removeVideoKVO];
    self.player = nil;
}

- (void)playbackFinished:(NSNotification *)notice {
    if ([self.delegate respondsToSelector:@selector(audioPlayerState:)]) {
        [self.delegate audioPlayerState:AudioPlayerStatusEnd];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.songItem.status) {//通过item的status判断网络音频播放状态。player的status只能判断播放器自己的状态。
            case AVPlayerStatusUnknown:
                _audioPlayerStatus = AudioPlayerStatusUnknown;
                break;
            case AVPlayerStatusReadyToPlay:
                _audioPlayerStatus = AudioPlayerStatusReadyToPlay;
//                CMTime duration = self.songItem.duration;// 获取视频总长度
//                CGFloat totalSecond = self.songItem.duration.value / self.songItem.duration.timescale;// 转换成秒
                break;
            case AVPlayerStatusFailed:
                _audioPlayerStatus = AudioPlayerStatusFailed;
                break;
            default:
                break;
        }
        if ([self.delegate respondsToSelector:@selector(audioPlayerState:)]) {
            [self.delegate audioPlayerState:_audioPlayerStatus];
        }
    }
}
- (void)removeVideoKVO {
    [_songItem removeObserver:self forKeyPath:@"status"];
}
- (void)removeVideoNotic {
    //
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
