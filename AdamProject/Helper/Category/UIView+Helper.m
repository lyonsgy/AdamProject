//
//  UIView+Helper.m
//  Jikebaba
//
//  Created by nplus on 15/7/21.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)
-(void)addSubviews:(NSArray *)objects
{
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[UIView class]])
        {
            [self addSubview:obj];
        }
    }];
}

-(void)removeAllSubView{
    for(UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
}
@end
