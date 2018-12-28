//
//  NPAreaPickerView.m
//  ThreePigsPianoParents
//
//  Created by NPlus on 2017/1/22.
//  Copyright © 2017年 nplus. All rights reserved.
//

#import "NPAreaPickerView.h"
@implementation NPAreaPickerView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, frame.size.height)];
    if(self)
    {
        [self setCustomView];
        self.hidden = YES;
    }
    return self;
}
- (void)dealloc{
    
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    //xib加载会调用这个方法
    [self setCustomView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //子控件的尺寸自定义
}
-(void)setCustomView{
    DZMAreaPickerView *areaPickerView = [DZMAreaPickerView areaPickerViewWithaDelegate:self openDelegate:YES];
    areaPickerView.frame = CGRectMake(0, 44, ScreenWidth, self.frame.size.height-44);
    [self addSubview:areaPickerView];
    WS(wself)
    UIToolbar *bar=[UIToolbar new];
    [bar setFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    UIButton* cancelbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelbtn.tz_height = 44;
    cancelbtn.tz_width = 44;
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelbtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [cancelbtn setTitleColor:[UIColor colorWithHex:NPGreyishBrownTwo] forState:UIControlStateNormal];
    [cancelbtn bk_addEventHandler:^(id sender) {
        [wself resignFirstResponder];
        [wself hide];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIButton*okbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    okbtn.tz_height = 44;
    okbtn.tz_width = 44;
    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
    okbtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [okbtn setTitleColor:[UIColor colorWithHex:NPGreyishBrownTwo] forState:UIControlStateNormal];
    [okbtn bk_addEventHandler:^(id sender) {
        [wself resignFirstResponder];
        if (self.delegate && [self.delegate respondsToSelector:@selector(areaPickerViewCurrentProvinceModel:currentCityModel:currentAreaModel:)])
        {
            [self.delegate areaPickerViewCurrentProvinceModel:_currentProvinceModel currentCityModel:_currentCityModel currentAreaModel:_currentAreaModel];
        }
        [wself hide];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UILabel*titleLabel=[[UILabel alloc]init];
    titleLabel.tz_height = 44;
    titleLabel.tz_width = 100;
    titleLabel.textColor=[UIColor colorWithHex:NPGreyishBrownTwo];
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.text=@"选择地址";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelbtn];
    UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithCustomView:okbtn];
    UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
    
    NSArray *items = @[cancelItem,flexibleitem,titleItem,flexibleitem,okItem];
    [bar setItems:items animated:YES];
    
    [bar setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:bar];
}

#pragma mark - Action
- (void)show{
    self.hidden = NO;
    [UIView animateWithDuration:.3 animations:^{
        //显示
        self.mj_y = ScreenHeight - self.mj_h-64;
    }];
}
- (void)hide{
    [UIView animateWithDuration:.3 animations:^{
        //隐藏
        self.mj_y = ScreenHeight;
    }];
}
#pragma mark - DZMAreaPickerViewDelegate
- (void)areaPickerView:(DZMAreaPickerView *)areaPickerView currentProvinceModel:(DZMProvinceModel *)currentProvinceModel currentCityModel:(DZMCityModel *)currentCityModel currentAreaModel:(DZMAreaModel *)currentAreaModel
{
    _currentProvinceModel = currentProvinceModel;
    _currentCityModel = currentCityModel;
    _currentAreaModel = currentAreaModel;
    
    NSLog(@"name - %@     %@     %@",currentProvinceModel.b,currentCityModel.b,currentAreaModel.b);
    NSLog(@"id   - %@     %@     %@",currentProvinceModel.c,currentCityModel.c,currentAreaModel.c);
}
@end
