//
//  NPButtonAnimationHelp.m
//  Jikebaba
//
//  Created by lyons on 2017/7/5.
//  Copyright © 2017年 NewZhiWei. All rights reserved.
//

#import "NPButtonAnimationHelp.h"

@implementation NPButtonAnimationHelp
+(void)clickAiomationWithButton:(UIButton*)button{
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:1];
    pulse.toValue= [NSNumber numberWithFloat:.9];
    [[button layer] addAnimation:pulse forKey:nil];
}
@end
