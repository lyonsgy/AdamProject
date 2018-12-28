//
//  UIButton+UI.m
//  SYUI
//
//  Created by Syousoft on 16/5/23.
//  Copyright © 2016年 Syousoft. All rights reserved.
//

#import "UIButton+UI.h"
#import "UIColor+Hex.h"
#import <objc/runtime.h>

#define NormalControlState @"nor"
#define HighlightedControlState @"pre"
#define SelectedControlState @"sel"
#define DisabledControlState @"dis"
@implementation UIButton (UI)
@dynamic sy_titleColorHex;
static char kPropertySy_titleColorHex;
- (NSInteger)sy_titleColorHex
{
    return (NSInteger)objc_getAssociatedObject(self, &kPropertySy_titleColorHex );
}
@dynamic sy_titleFont;
static char kPropertySy_titleFont;
- (CGFloat)sy_titleFont
{
    return (NSInteger)objc_getAssociatedObject(self, &kPropertySy_titleFont );
}

-(void)setSy_titleColorHex:(NSInteger)sy_titleColorHex{
    [self setTitleColor:[UIColor colorWithHex:sy_titleColorHex] forState:UIControlStateNormal];
}

-(void)setSy_titleFont:(CGFloat)sy_titleFont{
    self.titleLabel.font = [UIFont systemFontOfSize:sy_titleFont];
}
/**
 *  用颜色添加按钮的backgroundImage
 *
 *  @param hexs   颜色
 *  @param states 对应颜色的StateString：nor(normal)、pre(highlighted)、sel(selected)、dis(disabled).
 */
-(void)setBackgroundImageWithHexs:(NSArray *)hexs andStateArray:(NSArray *)states{
    for (int i=0; i<hexs.count; i++) {
        if ([states[i] isEqualToString:NormalControlState]) {
            [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:strtoul([hexs[i] UTF8String],0,0)] size:CGSizeMake(2, 2)] forState:UIControlStateNormal];
        }
        if ([states[i] isEqualToString:HighlightedControlState]) {
            
            [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:strtoul([hexs[i] UTF8String],0,0)] size:CGSizeMake(2, 2)] forState:UIControlStateHighlighted];
        }
        if ([states[i] isEqualToString:SelectedControlState]) {
            
            [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:strtoul([hexs[i] UTF8String],0,0)] size:CGSizeMake(2, 2)] forState:UIControlStateSelected];
        }
        if ([states[i] isEqualToString:DisabledControlState]) {
            [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:strtoul([hexs[i] UTF8String],0,0)] size:CGSizeMake(2, 2)] forState:UIControlStateDisabled];
        }
    }
}

/**
 *  添加按钮的backgroundImage
 *
 *  @param imageArray 图片后缀格式：_nor(normal)、_pre(highlighted)、_sel(selected)、_dis(disabled).
 *  @param insets     The values to use for the cap insets.
 */
-(void)setBackgroundImages:(NSArray *)imageArray andInsets:(UIEdgeInsets)insets{
    for (int i=0; i<imageArray.count; i++) {
        NSRange range = [imageArray[i] rangeOfString:@"_"]; //现获取要截取的字符串位置
        NSString * result = [imageArray[i] substringFromIndex:range.location+1]; //截取字符串
        if ([result isEqualToString:NormalControlState]) {
            [self setBackgroundImage:[[UIImage imageNamed:imageArray[i]] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        }
        if ([result isEqualToString:HighlightedControlState]) {
            [self setBackgroundImage:[[UIImage imageNamed:imageArray[i]] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
        }
        if ([result isEqualToString:SelectedControlState]) {
            [self setBackgroundImage:[[UIImage imageNamed:imageArray[i]] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch] forState:UIControlStateSelected];
        }
        if ([result isEqualToString:DisabledControlState]) {
            [self setBackgroundImage:[[UIImage imageNamed:imageArray[i]] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch] forState:UIControlStateDisabled];
        }
    }
}
/**
 *  添加按钮的image
 *
 *  @param imageArray 图片后缀格式：_nor(normal)、_pre(highlighted)、_sel(selected)、_dis(disabled).
 */
-(void)setImages:(NSArray *)imageArray{
    for (int i=0; i<imageArray.count; i++) {
        NSRange range = [imageArray[i] rangeOfString:@"_"]; //现获取要截取的字符串位置
        NSString * result = [imageArray[i] substringFromIndex:range.location+1]; //截取字符串
        if ([result isEqualToString:NormalControlState]) {
            [self setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        }
        if ([result isEqualToString:HighlightedControlState]) {
            [self setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateHighlighted];
        }
        if ([result isEqualToString:SelectedControlState]) {
            [self setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateSelected];
        }
        if ([result isEqualToString:DisabledControlState]) {
            [self setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateDisabled];
        }
    }
}
@end
