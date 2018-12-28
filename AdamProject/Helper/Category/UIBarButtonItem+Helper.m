//
//  UIBarButtonItem+Helper.m
//  Jikebaba
//
//  Created by nplus on 15/7/23.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "UIBarButtonItem+Helper.h"
#import "UIControl+BlocksKit.h"
@implementation UIBarButtonItem (Helper)
+(UIBarButtonItem *)createBarButtonItemWithNorImage:(UIImage *)image
                                       WithPreImage:(UIImage *)preImage
                                        WithHandle:(void (^)(id sender))handler
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0,44,44)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:preImage forState:UIControlStateHighlighted];
    [button bk_addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
    return item;
}
@end
