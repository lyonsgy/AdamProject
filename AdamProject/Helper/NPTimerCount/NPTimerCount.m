//
//  NPTimerCount.m
//  GCD CountTDemo
//
//  Created by NPlus on 2017/1/14.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "NPTimerCount.h"

@interface NPTimerCount ()
{
    dispatch_source_t timer;
}
@property (nonatomic) BOOL isStart;
@property (nonatomic) BOOL isPause;
@property (nonatomic) BOOL isCreate;
@end

@implementation NPTimerCount
- (id)init{
    _timeCount = 0;
    
    return self;
}

-(void)start{
    if (!_isStart) {
        [self startToCountTime];
        _isPause = NO;
        _isStart = YES;
    }
}

- (void)pause{
    dispatch_suspend(timer);
    _isPause = YES;
    _isStart = NO;
}

- (void)stop{
    if (_isCreate){
        if (_isPause == YES) {
            dispatch_resume(timer);
            
        }
        dispatch_source_cancel(timer);
        _isStart = NO;
        _timeCount = 0;
        _isCreate = NO;
    }
}

- (void)startToCountTime
{
    if (_isCreate == NO) {
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
        _isCreate = YES;
    }
    
    //    每秒执行一次
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
//        NSInteger hours = _timeCount / 3600;
//        NSInteger minutes = (_timeCount - (3600*hours)) / 60;
//        NSInteger seconds = _timeCount%60;
//        NSString *strTime = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",(long)hours,(long)minutes,(long)seconds];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //           ======在这根据自己的需求去刷新UI==============
            NSLog(@"___%ld",(long)_timeCount);
            
        });
        _timeCount ++;
    });
    
    dispatch_resume(timer);
    
}
- (void)invalidate{
    
}
@end
