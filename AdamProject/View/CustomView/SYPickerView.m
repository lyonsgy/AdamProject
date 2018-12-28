//
//  SYUserPickerView.m
//  SYTools
//
//  Created by nplus on 16/3/15.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import "SYPickerView.h"
#import "Masonry.h"




@implementation SYPickerView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
        _picker=[UIPickerView new];
        _bar=[UIToolbar new];
        _cancelbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelbtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_cancelbtn setTitleColor:[UIColor colorWithHex:NPGreyishBrownTwo alpha:.35] forState:UIControlStateNormal];
        [_cancelbtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bar addSubview:_cancelbtn];
        
        
        [_cancelbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(66, 44));
            make.centerY.mas_equalTo(_bar.mas_centerY).with.offset(0);
            make.leading.mas_equalTo(_bar.mas_leading).with.offset(5);
        }];
        
        
        _okbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_okbtn setTitle:@"确定" forState:UIControlStateNormal];
        _okbtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_okbtn setFrame:CGRectMake(0, 0, 66, 44)];
        [_okbtn setTitleColor:[UIColor colorWithHex:NPGreyishBrownTwo alpha:.35] forState:UIControlStateNormal];
        [_okbtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bar addSubview:_okbtn];
        [_okbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(66, 44));
            make.centerY.mas_equalTo(_bar.mas_centerY).with.offset(0);
            make.trailing.mas_equalTo(_bar.mas_trailing).with.offset(5);
        }];        
        
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.textColor=[UIColor blackColor];
        _titleLabel.font=[UIFont systemFontOfSize:15];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [_bar addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(_cancelbtn.mas_right).with.offset(5);
            make.right.mas_equalTo(_okbtn.mas_left).with.offset(-5);
            make.centerY.mas_equalTo(_bar.mas_centerY).with.offset(0);
        }];
        
        
        [_bar setBackgroundColor:[UIColor lightGrayColor]];
        
        [self addSubview:_picker];
        [self addSubview:_bar];
        [_picker setBackgroundColor:[UIColor whiteColor]];
        
        [_bar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.height.mas_equalTo(50);
            make.bottom.mas_equalTo(50);
        }];
        
        __weak typeof(self)wself=self;
        [self addTarget:wself action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}
-(void)setTitleString:(NSString *)titleString
{
    _titleLabel.text=titleString;
}
-(void)setToolBarbuttonColor:(UIColor*)color ForState:(UIControlState)state
{
    [_cancelbtn setTitleColor:color forState:state];
    [_okbtn setTitleColor:color forState:state];
}
-(void)setDelegate:(id<SYPickerViewDelegate>)delegate
{
    _picker.delegate=delegate;
    _delegate=delegate;
}
-(void)setDataSource:(id<SYPickerViewDataSource>)dataSource
{
    _picker.dataSource=dataSource;
    _dataSource=dataSource;
    
    _pickerHeight=[_dataSource heightOfPickerView:self];
    [_picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bar.mas_bottom);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(_pickerHeight);
    }];
}
#pragma mark ---cancel----
-(IBAction)cancelAction:(id)sender
{
    [self dismissDatePicker];
    if([_delegate respondsToSelector:@selector(dismissPickerView:)])
    {
        [_delegate dismissPickerView:self];
    }
}
-(IBAction)okAction:(id)sender
{
    [self dismissDatePicker];
    if([_delegate respondsToSelector:@selector(submitPickerView:)])
    {
        [_delegate submitPickerView:self];
    }
}
-(void)showDatePickerInSuperView:(UIView *)superView
{

    [superView addSubview:self];
    self.frame =CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height);
    [self layoutIfNeeded];
    [_bar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(-_pickerHeight);
    }];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [_picker reloadAllComponents];
    }];
}
-(void)dismissDatePicker
{
    [_bar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(50);
    }];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
  
}
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    if (_picker)
    {
        [_picker selectRow:row inComponent:component animated:animated];
    }
}
-(NSInteger)selectRowIncomponent:(NSInteger)component
{
   NSInteger index= [_picker selectedRowInComponent:component];
    if(index<0)
        index=0;
    return index;
}
- (void)reloadAllComponents
{
    if (_picker)
    {
        [_picker reloadAllComponents];
    }
}
- (void)reloadComponent:(NSInteger)component
{
    if (_picker)
    {
        [_picker reloadComponent:component];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
