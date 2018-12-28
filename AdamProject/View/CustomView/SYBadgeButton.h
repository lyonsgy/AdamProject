//
//  SYBadgeButton.h
//  Jikebaba
//
//  Created by Syousoft2 on 15/9/16.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYBadgeButton : UIButton
@property(nonatomic,strong)UILabel * customTitleLabel;
@property(nonatomic,strong)UIView * badgeView;
@property(nonatomic,assign)BOOL isSelect;
-(id)initWithTitle:(NSString *)title withTitleFont:(UIFont *)font withTitleColor:(UIColor *)color;
-(id)initWithNormalImageStr:(NSString *)normalImageStr withHightLightImageStr:(NSString *)hightLightStr;
//- (void)setTitle:(NSString *)title forState:(UIControlState)state;                     
//- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
//-(id)initWithTitle:(NSString *)title withTitleFont:(UIFont *)font;

@end
