//
//  NPRefreshGifHeader.m
//  KidsYan
//
//  Created by lyons on 2017/5/31.
//  Copyright © 2017年 NewZhiWei. All rights reserved.
//

#import "NPRefreshGifHeader.h"

@implementation NPRefreshGifHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    self.stateLabel.hidden = YES;
    // 设置普通状态的动画图片
    //    NSMutableArray *idleImages = [NSMutableArray array];
    //    for (NSUInteger i = 1; i<=60; i++) {
    //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
    //        [idleImages addObject:image];
    //    }
    //    [self setImages:@[[UIImage imageNamed:@"tableHeader_refresh"]] forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    //    NSMutableArray *refreshingImages = [NSMutableArray array];
    //    for (NSUInteger i = 1; i<=3; i++) {
    //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
    //        [refreshingImages addObject:image];
    //    }
    //    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    //    [self setImages:@[[UIImage imageNamed:@"tableHeader_refresh"]] forState:MJRefreshStateRefreshing];
}

- (void)placeSubviews
{
    [super placeSubviews];
    [self.refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-20);
        make.left.mas_equalTo(self.mas_left).with.offset(0);
        make.right.mas_equalTo(self.mas_right).with.offset(0);
    }];
}
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    [super setState:state];
    //    if (self.state == MJRefreshStateNoMoreData) {
    //        self.endPageView.hidden = NO;
    //    }else{
    //        self.endPageView.hidden = YES;
    //    }
}
- (UIView *)refreshView
{
    if (!_refreshView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_refreshView = gifView];
        _refreshView.image = [UIImage imageNamed:@"tableHeader_refresh"];
        _refreshView.contentMode = UIViewContentModeCenter;
        self.refreshView.tz_height = _refreshView.image.size.height;
    }
    return _refreshView;
}
@end

