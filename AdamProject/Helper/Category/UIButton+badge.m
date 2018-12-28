//
//  UIButton+badge.m
//  Jikebaba
//
//  Created by Nplus on 2017/3/7.
//  Copyright © 2017年 nplus. All rights reserved.
//

#import "UIButton+badge.h"

@implementation UIButton (badge)
//显示小红点
- (void)showBadgeOnItemIndex{
    //移除之前的小红点
    [self removeBadgeOnItemIndex];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888;
    badgeView.layer.cornerRadius = 3;//圆形
    badgeView.backgroundColor = [UIColor colorWithHex:0xff7c66];//颜色：红色
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    CGFloat x = ceilf(tabFrame.size.width-12);
    CGFloat y = ceilf((tabFrame.size.height-6)/2);
    badgeView.frame = CGRectMake(x, y, 6, 6);//圆形大小为10
    [self addSubview:badgeView];
}
//隐藏小红点
- (void)hideBadgeOnItemIndex{
    //移除小红点
    [self removeBadgeOnItemIndex];
}
//移除小红点
- (void)removeBadgeOnItemIndex{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888) {
            [subView removeFromSuperview];
        }
    }
}
@end
