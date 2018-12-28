//
//  SYTimeButton.h
//  SYUI
//
//  Created by Syousoft on 16/5/20.
//  Copyright © 2016年 Syousoft. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface SYTimeButton : UIButton

@property(nonatomic)NSInteger totalSecond;
@property(nonatomic,strong)NSString *restartString;
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withRestartTitle:(NSString *)restartTitle withSecond:(NSInteger)second;
-(void)restart;
-(void)pauseTimer;
-(void)startTimer;
@end
