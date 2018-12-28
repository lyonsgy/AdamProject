//
//  SYBadgeButton.m
//  Jikebaba
//
//  Created by Syousoft2 on 15/9/16.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "SYBadgeButton.h"

@implementation SYBadgeButton
-(id)initWithTitle:(NSString *)title withTitleFont:(UIFont *)font withTitleColor:(UIColor *)color
{
    self=[super init];
    if (self)
    {
        if (title && title.length)
        {
            _customTitleLabel=[UILabel new];
            _customTitleLabel.text=title;
            _customTitleLabel.font=font;
            _customTitleLabel.textColor=color;
            [self addSubview:_customTitleLabel];
            float titleWidth=[title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, ceil(font.lineHeight)) withTextFont:font withLineSpacing:0].width;
            WS(weakSelf)
            [_customTitleLabel mas_makeConstraints:^(MASConstraintMaker *maker){
            
                maker.size.mas_equalTo(CGSizeMake(titleWidth, ceil([font lineHeight])));
                maker.center.equalTo(weakSelf);
            }];
            
            _badgeView=[UIView new];
            _badgeView.backgroundColor=[UIColor colorWithHex:0xe85237];
            _badgeView.layer.cornerRadius=4;
            _badgeView.layer.masksToBounds=YES;
            [self addSubview:_badgeView];
            
            [_badgeView mas_makeConstraints:^(MASConstraintMaker * maker){
            
                maker.size.mas_equalTo(CGSizeMake(8, 8));
                maker.left.equalTo(_customTitleLabel.mas_right).with.offset(0);
                maker.top.equalTo(_customTitleLabel.mas_top).with.offset(-3);
            }];
        }
    }
    return self;
}

-(id)initWithNormalImageStr:(NSString *)normalImageStr withHightLightImageStr:(NSString *)hightLightStr
{
    self=[super init];
    if (self)
    {
        
        UIImage * normalImage=[UIImage imageNamed:normalImageStr];
        [self setImage:[UIImage imageNamed:normalImageStr] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:hightLightStr] forState:UIControlStateHighlighted];
        
        _badgeView=[UIView new];
        _badgeView.backgroundColor=[UIColor colorWithHex:0xe85237];
        _badgeView.layer.cornerRadius=4;
        _badgeView.layer.masksToBounds=YES;
        [self addSubview:_badgeView];
        WS(weakSelf)
        [_badgeView mas_makeConstraints:^(MASConstraintMaker * maker){
            
            maker.size.mas_equalTo(CGSizeMake(8, 8));
            maker.left.equalTo(weakSelf.mas_centerX).with.offset(normalImage.size.width/2-2);
            maker.top.equalTo(weakSelf.mas_centerY).with.offset(-normalImage.size.height/2-4);
        }];
         
    }
    return self;
}
@end
