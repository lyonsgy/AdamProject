//
//  UITableViewCell+Helper.m
//  Jikebaba
//
//  Created by nplus on 15/7/21.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "UITableViewCell+Helper.h"

@implementation UITableViewCell (Helper)
-(void)setSelectColor:(UIColor *)color
{
    UIView *backgroundView=[UIView new];
    [backgroundView setBackgroundColor:color];
    [self setSelectedBackgroundView:backgroundView];
}
@end
