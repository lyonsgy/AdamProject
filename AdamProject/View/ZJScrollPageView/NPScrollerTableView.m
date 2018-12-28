//
//  NPScrollerTableView.m
//  Jikebaba
//
//  Created by lyons on 2018/2/27.
//  Copyright © 2018年 cookcreative. All rights reserved.
//

#import "NPScrollerTableView.h"

@implementation NPScrollerTableView
// 返回YES同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer* pan = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint p = [pan translationInView:pan.view];
        if(fabs(p.y)<fabs(p.x) && p.x > 0)
        {
            return NO;
        }else{
            return YES;
        }
    }
    return NO;
}


@end
