//
//  NPCalendar.m
//  Jikebaba
//
//  Created by lyons on 2017/12/26.
//  Copyright © 2017年 cookcreative. All rights reserved.
//

#import "NPCalendar.h"

@implementation NPCalendar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initCustomView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    WS(wself)
    [_calendarHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.mas_top).with.offset(0);
        make.left.mas_equalTo(wself.mas_left).with.offset(0);
        make.right.mas_equalTo(wself.mas_right).with.offset(0);
        make.height.mas_equalTo(wself.headerHeight);
    }];
}

- (void)initCustomView
{
    self.appearance.todayColor = [UIColor colorWithHex:0x000000];
    self.calendarHeaderView.hidden = true;
    self.calendarHeadView = [NPCalendarHeaderView new];
    [self addSubview:_calendarHeadView];
    
}

@end
