//
//  SYNoDataShowView.m
//  Jikebaba
//
//  Created by nplus on 15/4/27.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "SYNoDataShowView.h"
#import "Masonry.h"
@implementation SYNoDataShowView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        [self setBackgroundColor:[UIColor colorWithHex:NPBackgroundColor]];
        _showImage=[UIImageView new];
        _showLabel=[UILabel new];
        [_showLabel setTextColor:[UIColor colorWithHex:0xDBDBDB]];
        [_showLabel setFont:[UIFont systemFontOfSize:15]];
        _showImage.image = [UIImage imageNamed:@"default_nodata&error"];
        _showImage.contentMode = UIViewContentModeCenter;
        
        _showSubLabel=[UILabel new];
        [_showSubLabel setTextColor:[UIColor colorWithHex:0xDBDBDB]];
        [_showSubLabel setFont:[UIFont systemFontOfSize:15]];
        
        [self addSubview:_showImage];
        [self addSubview:_showLabel];
        [self addSubview:_showSubLabel];
        
        WS(wself)
        _showLabel.numberOfLines=0;
        _showLabel.textAlignment = NSTextAlignmentCenter;
        [_showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wself);
            make.centerY.equalTo(wself).with.offset(-35);
            make.height.mas_greaterThanOrEqualTo(0);
            make.width.mas_lessThanOrEqualTo(300);
        }];
        [_showImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@[_showLabel]).with.offset(5);
            make.width.mas_equalTo(285*.4);
            make.height.mas_equalTo(251*.4);
            make.bottom.equalTo(_showLabel.mas_top).with.offset(-ScreenHeight*.1+35);
        }];
        _showSubLabel.numberOfLines=0;
        [_showSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_showLabel.mas_bottom).with.offset(15);
            make.height.mas_greaterThanOrEqualTo(0);
            make.width.mas_lessThanOrEqualTo(300);
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
