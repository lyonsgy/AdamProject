//
//  NPCalendarHeaderView.m
//  Jikebaba
//
//  Created by lyons on 2017/12/27.
//  Copyright © 2017年 cookcreative. All rights reserved.
//

#import "NPCalendarHeaderView.h"

@implementation NPCalendarHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCustomView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    WS(wself)
    [_selectMonthLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.mas_top).with.offset(PX_TRANS(20));
        make.right.mas_equalTo(wself.mas_right).with.offset(-PX_TRANS(16));
        make.height.mas_equalTo(PX_TRANS(24));
    }];
    [_selectWeekdayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.mas_top).with.offset(PX_TRANS(18));
        make.left.mas_equalTo(wself.mas_left).with.offset(PX_TRANS(16));
        make.height.mas_equalTo(PX_TRANS(20));
    }];
    [_selectDayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wself.selectWeekdayLab.mas_bottom).with.offset(PX_TRANS(6));
        make.centerX.mas_equalTo(wself.selectWeekdayLab.mas_centerX).with.offset(0);
    }];
}

- (void)setCustomView
{
    _selectMonthLab = [UILabel new];
    _selectDayLab = [UILabel new];
    _selectWeekdayLab = [UILabel new];
    [self addSubview:_selectMonthLab];
    [self addSubview:_selectDayLab];
    [self addSubview:_selectWeekdayLab];
    
    _selectMonthLab.textColor = [UIColor colorWithHex:NPGreyishBrownTwo alpha:.87];
    _selectMonthLab.textAlignment = NSTextAlignmentRight;
    _selectMonthLab.font = [UIFont systemFontOfSize:PT_TRANS(24)];
    
    _selectDayLab.textColor = [UIColor colorWithHex:NPGreyishBrownTwo alpha:.87];
    _selectDayLab.font = [UIFont systemFontOfSize:PT_TRANS(26)];
    
    _selectWeekdayLab.textColor = [UIColor colorWithHex:NPGoldenRod];
    _selectWeekdayLab.font = [UIFont systemFontOfSize:PT_TRANS(20)];
    
    self.selectDate = [NSDate new];
    
}

- (void)setSelectDate:(NSDate *)selectDate
{
    _selectDate = selectDate;
    NSCalendar *calendars = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    comps = [calendars components:unitFlags fromDate:selectDate];
    self.selectDayLab.text = [NSString stringWithFormat:@"%ld",(long)[comps day]];
    self.selectMonthLab.text = [NSString stringWithFormat:@"%ld",(long)[comps month]];
    self.selectDayLab.text = [NSString stringWithFormat:@"%ld",(long)[comps day]];
    NSArray *weekdayArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    self.selectWeekdayLab.text = weekdayArray[[comps weekday]-1];
    NSArray *monthArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    self.selectMonthLab.text = monthArray[[comps month]-1];

}
@end
