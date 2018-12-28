//
//  SYUserPickerView.h
//  SYTools
//
//  Created by nplus on 16/3/15.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYPickerView;
@protocol SYPickerViewDataSource <UIPickerViewDataSource>
@required
- (CGFloat)heightOfPickerView:(SYPickerView *)pickerView;
@end
@protocol SYPickerViewDelegate <UIPickerViewDelegate>

- (void)dismissPickerView:(SYPickerView *)pickerView;
- (void)submitPickerView:(SYPickerView *)pickerView;

@end
@interface SYPickerView : UIControl
{
    UIPickerView *_picker;
    UIToolbar *_bar;
    CGFloat _pickerHeight;
    UIButton *_cancelbtn;
    UIButton *_okbtn;
    UILabel *_titleLabel;
}
@property (nonatomic,copy)NSString *titleString;
@property (nonatomic,weak)id<SYPickerViewDelegate>delegate;
@property (nonatomic,weak)id<SYPickerViewDataSource>dataSource;
-(void)setToolBarbuttonColor:(UIColor*)color ForState:(UIControlState)state;
-(void)showDatePickerInSuperView:(UIView *)superView;
-(void)dismissDatePicker;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
-(NSInteger)selectRowIncomponent:(NSInteger)component;
- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;
@end
