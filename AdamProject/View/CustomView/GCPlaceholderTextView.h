//
//  GCPlaceholderTextView.h
//  GCLibrary
//
//  Created by Guillaume Campagna on 10-11-16.
//  Copyright 2010 LittleKiwi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GCPlaceholderTextView : UITextView
@property(nonatomic,assign)CGFloat textLeftMargin;//左边界
@property(nonatomic,assign)CGFloat textTopMargin;//上边界
@property(nonatomic, strong) NSString *placeholder;
@property(nonatomic, assign) NSInteger limitLength;
@property(nonatomic, assign) BOOL isOpenNotification;
@property(nonatomic, strong) NSString *beyongLimitLengthMessage;
-(void)textFiledEditChanged:(NSNotification *)obj;
@end
