//
//  SYNetworkErrorView.m
//  Jikebaba
//
//  Created by nplus on 15/4/30.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "SYNetworkErrorView.h"
#import "Masonry.h"
@implementation SYNetworkErrorView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        [self setBackgroundColor:[UIColor colorWithHex:NPBackgroundColor]];
        _showLabel=[UILabel new];
         _showImage=[UIImageView new];
        [_showLabel setTextColor:[UIColor colorWithHex:0xDBDBDB]];
        _showImage.image = [UIImage imageNamed:@"default_nodata&error"];
        _showImage.contentMode = UIViewContentModeCenter;
        
        _showLabel.sy_textFont = 15;
        _operationButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _operationButton.sy_titleFont = 15;
        [_operationButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [_operationButton setTitleColor:[UIColor colorWithHex:NPGoldenRod]  forState:UIControlStateNormal];
        [self addSubview:_showLabel];
        [self addSubview:_operationButton];
        [self addSubview:_showImage];
        
        WS(wself)
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
        
        [_operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@[_showLabel]);
            make.top.equalTo(_showLabel.mas_bottom).with.offset(6);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(150);
        }];
    }
    return self;
}
@end
