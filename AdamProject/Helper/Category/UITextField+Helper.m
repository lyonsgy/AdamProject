//
//  UITextField+Helper.m
//  Jikebaba
//
//  Created by nplus on 15/5/15.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "UITextField+Helper.h"

@implementation UITextField (Helper)
static char kPropertyLimitlength;
ADD_DYNAMIC_PROPERTY_COPY(SYInputAccessoryViewBlock, accessoryViewBlock, setAccessoryViewBlock);
@dynamic limitlength;

-(void)setLimitlength:(NSInteger)limitlength
{
    objc_setAssociatedObject(self, &kPropertyLimitlength ,@(limitlength), OBJC_ASSOCIATION_RETAIN);
}
-(NSInteger)limitlength
{
    NSNumber *number=objc_getAssociatedObject(self, &kPropertyLimitlength );
    return [number integerValue];
}

-(void)addSpaceToTextField:(CGFloat)space
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, space, space)];
    [view setBackgroundColor:[UIColor clearColor]];
    self.leftViewMode=UITextFieldViewModeAlways;
    self.leftView=view;
}
-(void)addCloseKeyBoardButton
{
    UIToolbar *bar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,MAINSCREEN.size.width,44)];
    UIBarButtonItem *close=[[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeKeyBoard:)];
    UIBarButtonItem *fitem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [bar setItems:@[fitem,close]];
    self.inputAccessoryView=bar;
}
-(void)closeKeyBoard:(id)sender
{
    [self resignFirstResponder];
}
-(NSRange)selectedRanges
{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}
-(void)setSelectedRanges:(NSRange)range
{
    UITextPosition* beginning = self.beginningOfDocument;
    if (range.location>self.text.length)
        range.location=self.text.length;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

+ (void)printAllMethod
{
    
    unsigned int outCount, i;
    Method *properties =class_copyMethodList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        Method property = properties[i];
        SEL method_sel = method_getName(property);
        NSLog(@"mehod name is %@",NSStringFromSelector(method_sel));
    }
    free(properties);
    
}

-(void)setDatePickerWithSelected:(SYInputAccessoryViewBlock)finishBlock;
{
    self.accessoryViewBlock=finishBlock;
    UUDatePicker *datePicker=[[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, MAINSCREEN.size.width, 180) PickerStyle:UUDateStyle_YearMonthDay didSelected:^(NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
        ;
    }];
    datePicker.minLimitDate=[NSDate date];
    datePicker.currentDate=datePicker.minLimitDate;
    WS(wself)
    UIView * bar=[UIToolbar new];
    [bar setFrame:CGRectMake(0, 0, MAINSCREEN.size.width, 44)];
    UIButton* cancelbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [cancelbtn setTitleColor:[UIColor colorWithHex:NPGreyishBrownTwo alpha:.35] forState:UIControlStateNormal];
    
    [cancelbtn bk_addEventHandler:^(id sender) {
       [wself resignFirstResponder];
        if(wself.accessoryViewBlock)
            wself.accessoryViewBlock(nil,YES);
        
    } forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:cancelbtn];
    
    [cancelbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(66, 44));
        make.centerY.mas_equalTo(bar.mas_centerY).with.offset(0);
        make.leading.mas_equalTo(bar.mas_leading).with.offset(5);
    }];
    UIButton*okbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
    okbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [okbtn setFrame:CGRectMake(0, 0, 66, 44)];
    [okbtn setTitleColor:[UIColor colorWithHex:NPGreyishBrownTwo alpha:.35] forState:UIControlStateNormal];
    [okbtn bk_addEventHandler:^(id sender) {
       [wself resignFirstResponder];
        if(wself.accessoryViewBlock)
            wself.accessoryViewBlock(((UUDatePicker *)wself.inputView).currentDate,NO);
    } forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:okbtn];
    [okbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(66, 44));
        make.centerY.mas_equalTo(bar.mas_centerY).with.offset(0);
        make.trailing.mas_equalTo(bar.mas_trailing).with.offset(5);
    }];
    
    UILabel*titleLabel=[[UILabel alloc]init];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font=[UIFont systemFontOfSize:15];
    titleLabel.text=@"选择时间";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [bar addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(cancelbtn.mas_right).with.offset(5);
        make.right.mas_equalTo(okbtn.mas_left).with.offset(-5);
        make.centerY.mas_equalTo(bar.mas_centerY).with.offset(0);
    }];
    [bar setBackgroundColor:[UIColor lightGrayColor]];
    self.inputAccessoryView=bar;
    self.inputView=datePicker;
    
}

@end
