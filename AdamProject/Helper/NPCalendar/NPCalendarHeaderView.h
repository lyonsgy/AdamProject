//
//  NPCalendarHeaderView.h
//  Jikebaba
//
//  Created by lyons on 2017/12/27.
//  Copyright © 2017年 cookcreative. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPCalendarHeaderView : UIView
@property (nonatomic ,strong)UILabel *selectMonthLab;
@property (nonatomic ,strong)UILabel *selectDayLab;
@property (nonatomic ,strong)UILabel *selectWeekdayLab;
@property (nonatomic ,strong)NSDate *selectDate;

@end
