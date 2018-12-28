//
//  NPRefreshAutoGifFooter.m
//  KidsYan
//
//  Created by lyons on 2017/5/31.
//  Copyright © 2017年 NewZhiWei. All rights reserved.
//

#import "NPRefreshAutoGifFooter.h"

@implementation NPRefreshAutoGifFooter
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    // 初始化文字
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"" forState:MJRefreshStateRefreshing];
    [self setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    self.refreshingTitleHidden = YES;
}
- (void)placeSubviews
{
    [super placeSubviews];
    self.endPageView.frame = self.bounds;
    self.endPageView.hidden = self.state != MJRefreshStateNoMoreData;
}
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    [super setState:state];
    if (self.state == MJRefreshStateNoMoreData) {
        self.endPageView.hidden = NO;
        self.loadingView.hidden = YES;
    }else{
        self.endPageView.hidden = YES;
        self.loadingView.hidden = NO;
    }
}
-(DGActivityIndicatorView *)loadingView{
    if (!_loadingView) {
        _loadingView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallPulse tintColor:[UIColor colorWithRed:99/255.0 green:210/255.0 blue:248/255.0 alpha:1.0]];
        [self addSubview:_loadingView];
        _loadingView.frame = CGRectMake(0, 0, ScreenWidth, self.frame.size.height);
        _loadingView.size = 32;
        [_loadingView startAnimating];
    }
    return _loadingView;
}

- (UIView *)endPageView
{
    if (!_endPageView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_endPageView = gifView];
        self.tz_height = 37;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (self.tz_height-12)/2, ScreenWidth, 12)];//底部图片位置
        [_endPageView addSubview:imageView];
        imageView.contentMode = UIViewContentModeCenter;
        _endPageView.layer.masksToBounds = YES;
        imageView.image = [UIImage imageNamed:@"default_footer"];
    }
    return _endPageView;
}
@end

