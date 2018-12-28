//
//  UILabel+Color.m
//  SYUI
//
//  Created by Syousoft on 16/5/23.
//  Copyright © 2016年 Syousoft. All rights reserved.
//

#import "UILabel+UI.h"
#import "UIColor+Hex.h"
#import <objc/runtime.h>
@implementation UILabel (UI)

@dynamic sy_textColorHex;
static char kPropertySy_textColorHex;
- (NSInteger)sy_textColorHex
{
    return (NSInteger)objc_getAssociatedObject(self, &kPropertySy_textColorHex );
}
- (void)setSy_textColorHex:(NSInteger)textColorHex{
    self.textColor = [UIColor colorWithHex:textColorHex];
}

@dynamic sy_textFont;
static char kPropertySy_textFont;
- (CGFloat)sy_textFont
{
    return (NSInteger)objc_getAssociatedObject(self, &kPropertySy_textFont );
}
- (void)setSy_textFont:(CGFloat)textFont{
    self.font = [UIFont systemFontOfSize:textFont];
}

@end
