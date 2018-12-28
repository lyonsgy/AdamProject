//
//  NPTimerCount.h
//  GCD CountTDemo
//
//  Created by NPlus on 2017/1/14.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPTimerCount : NSObject
@property (nonatomic,assign) NSInteger timeCount;

- (void)start;
- (void)pause;
- (void)stop;
- (void)invalidate;
@end
