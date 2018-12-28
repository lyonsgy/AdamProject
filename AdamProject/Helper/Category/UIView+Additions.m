//
//  UIView+Additions.m
//  Jikebaba
//
//  Created by lyons on 2018/1/23.
//  Copyright © 2018年 cookcreative. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
- (UIViewController *)viewController
{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = [next nextResponder];
        
    } while (next != nil);
    return nil;
}
@end
