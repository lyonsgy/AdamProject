//
//  UINavigationBar+SkinManager.m
//  SYTools
//
//  Created by nplus on 16/6/27.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import "UINavigationBar+SkinManager.h"
#import <objc/runtime.h>
static char kPropertyShadowLineView;
static char kPropertyIconView;
@implementation UINavigationBar (SkinManager)
@dynamic shadowLineView;
@dynamic iconImageView;

-(UIImageView *)shadowLineView
{
    return objc_getAssociatedObject(self, &kPropertyShadowLineView);
}
-(void)setShadowLineView:(UIImageView *)shadowLineView
{
    objc_setAssociatedObject(self, &kPropertyShadowLineView ,shadowLineView , OBJC_ASSOCIATION_RETAIN);
    [self addSubview:shadowLineView];
}
-(UIImageView *)iconImageView
{
    return objc_getAssociatedObject(self, &kPropertyIconView);
}
-(void)setIconImageView:(UIImageView *)iconImageView
{
    objc_setAssociatedObject(self, &kPropertyIconView ,iconImageView , OBJC_ASSOCIATION_RETAIN);
    [self addSubview:iconImageView];
}

-(void)setShadowLineImage:(UIImage *)image
{
    CGFloat height = image.size.height;
    if(!self.shadowLineView)
        self.shadowLineView=[[UIImageView alloc]initWithImage:image];
    CGRect rect = self.frame;
    [self.shadowLineView setFrame:CGRectMake(0, rect.size.height-height/2, rect.size.width, height)];
    self.shadowLineView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
}
-(void)setIconImage:(UIImage *)iconImage WithRigthOffset:(CGFloat)rightOffset TopOffset:(CGFloat)topOffset;
{
    CGFloat height = iconImage.size.height;
    if(!self.iconImageView)
        self.iconImageView=[[UIImageView alloc]initWithImage:iconImage];
    CGRect rect = self.frame;
    [self.iconImageView setFrame:CGRectMake(rect.size.width-rightOffset,rect.size.height-topOffset, iconImage.size.width, height)];
    self.iconImageView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
}
@end
