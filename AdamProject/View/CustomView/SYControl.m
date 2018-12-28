//
//  SYControl.m
//  Jikebaba
//
//  Created by nplus on 15/8/10.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "SYControl.h"

@implementation SYControl
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    __block  BOOL isHitSubView=[super pointInside:point withEvent:event];
 
    if(isHitSubView)
    {
        isHitSubView=NO;
        [[self subviews]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView *view=obj;
            if(CGRectContainsPoint(view.frame, point))
            {
                isHitSubView=YES;
                *stop=YES;
            }
        }];
    }
    return isHitSubView;
}

@end
