//
//  UITableViewCell+SkinManager.m
//  SYTools
//
//  Created by nplus on 16/6/27.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import "UITableViewCell+SkinManager.h"
#import <objc/runtime.h>
static char kPropertyCustomSeparator;
@implementation UITableViewCell (SkinManager)
-(UIImageView *)customSeparator
{
    return objc_getAssociatedObject(self, &kPropertyCustomSeparator);
}
-(void)setCustomSeparator:(UIImageView *)customSeparator
{
    objc_setAssociatedObject(self, &kPropertyCustomSeparator ,customSeparator , OBJC_ASSOCIATION_RETAIN);
    [self.contentView addSubview:customSeparator];
    CGRect frame =self.contentView.frame;
    [customSeparator setFrame:CGRectMake(0,frame.size.height-2, self.contentView.frame.size.width, 2)];
    customSeparator.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
}
-(void)setCustomSeparatorImage:(UIImage *)customSeparatorImage
{
    if(!self.customSeparator)
        self.customSeparator =[[UIImageView alloc]initWithImage:customSeparatorImage];
    else
        [self.customSeparator setImage:customSeparatorImage];
}
-(void)setCustomSeparatorInset:(UIEdgeInsets)inset
{
   [self.customSeparator setFrame:CGRectMake(inset.left,self.contentView.frame.size.height-2, self.contentView.frame.size.width-inset.left-inset.right,2)];
}
-(void)setCustomSeparatorColor:(UIColor*)color Inset:(UIEdgeInsets)inset
{
    if(!self.customSeparator)
        self.customSeparator =[[UIImageView alloc]init];
    self.customSeparator.backgroundColor = color;
    [self.customSeparator setFrame:CGRectMake(inset.left,self.contentView.frame.size.height-.5, self.contentView.frame.size.width-inset.left-inset.right,.5)];
}
@end
