//
//  SYTimeButton.m
//  SYUI
//
//  Created by Syousoft on 16/5/20.
//  Copyright © 2016年 Syousoft. All rights reserved.
//

#import "SYTimeButton.h"
@interface SYTimeButton ()
@property(nonatomic)NSInteger showSecond;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation SYTimeButton
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withRestartTitle:(NSString *)restartTitle withSecond:(NSInteger)second
{
    self = [super initWithFrame:frame];
    if (self) {
        if (title && title.length){
            [self setTitle:title forState:UIControlStateNormal];
        }
        if (restartTitle && restartTitle.length){
            _restartString = restartTitle;
        }
        _totalSecond = second;
        _showSecond = second;
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        [self pauseTimer];
        [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setTotalSecond:(NSInteger)totalSecond{
    if (!_totalSecond) {
        _totalSecond = totalSecond;
        _showSecond = totalSecond;
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        [self pauseTimer];
    }
}
-(void)setRestartString:(NSString *)restartString{
    if (!_restartString) {
        _restartString = restartString;
    }
}

-(void)touchUpInside:(id)sender{
   
    [self startTimer];
}

-(void)timeFireMethod
{
    self.enabled=NO;
    _showSecond=_showSecond-1;
    if (_showSecond==0)
    {
        [self restart];
    }
    else
    {
        [self setTitle:[NSString stringWithFormat:@"%lds",(long)_showSecond] forState:UIControlStateDisabled];
    }
}
-(void)restart{
    [self pauseTimer];
    _showSecond=_totalSecond;
    self.enabled=YES;
    [self setTitle:_restartString forState:UIControlStateNormal];
}
-(void)pauseTimer{
    [_timer setFireDate:[NSDate distantFuture]];
}
-(void)startTimer{
    _showSecond=_totalSecond;
    [_timer setFireDate:[NSDate distantPast]];
}

//- (void)drawRect:(CGRect)rect {
//    
//}


@end
