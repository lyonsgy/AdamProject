//
//  UITabBar+badge.h
//  Jikebaba
//
//  Created by Nplus on 2017/3/6.
//  Copyright © 2017年 nplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
