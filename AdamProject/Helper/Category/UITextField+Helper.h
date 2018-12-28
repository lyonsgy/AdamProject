//
//  UITextField+Helper.h
//  Jikebaba
//
//  Created by nplus on 15/5/15.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUDatePicker.h"

typedef void(^SYInputAccessoryViewBlock)(id object ,BOOL isCancel);
@interface UITextField (Helper)
{
    
}
@property (nonatomic,copy)SYInputAccessoryViewBlock accessoryViewBlock;
@property (nonatomic,assign)NSInteger limitlength;

-(void)addSpaceToTextField:(CGFloat)space;
-(void)addCloseKeyBoardButton;
-(void)closeKeyBoard:(id)sender;
- (NSRange)selectedRanges;
- (void) setSelectedRanges:(NSRange)range;
+ (void)printAllMethod;
-(void)setDatePickerWithSelected:(SYInputAccessoryViewBlock)finishBlock;
@end
