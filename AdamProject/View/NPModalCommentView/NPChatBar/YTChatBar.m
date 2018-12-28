//
//  YTChatBar.m
//  FinanceSecretary
//
//  Created by JDYX on 16/6/1.
//  Copyright © 2016年 JDYX. All rights reserved.
//

#import "YTChatBar.h"
#import "Masonry/Masonry.h"

#define kMaxHeight 60.0f
#define kMinHeight 45.0f
#define kFunctionViewHeight 210.0f
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface YTChatBar()<HPGrowingTextViewDelegate>
@property (assign, nonatomic) CGRect keyboardFrame;
@property (nonatomic) CGRect r;
@property (nonatomic, strong) UIButton *sendBtn;

@end

@implementation YTChatBar
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self loadNotice];
        [self loadBarView];
    }
    return self;
}

- (void)endInputing {
    self.textView.text = @"";
    [self.textView resignFirstResponder];
}

- (void)loadNotice {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)loadBarView {
    _sendBtn = [UIButton new];
    [self addSubview:_sendBtn];
    _sendBtn.titleLabel.sy_textFont = 20;
    [_sendBtn setImage:[UIImage imageNamed:@"评论发布"] forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.textView = [[HPGrowingTextView alloc] init];
    self.textView.isScrollable = YES;
    self.textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.textView.minNumberOfLines = 1;
    self.textView.maxNumberOfLines = 7;
    self.textView.textColor = [UIColor colorWithHex:0x434343];
    self.textView.backgroundColor = [UIColor colorWithHex:NPWhiteFive];
    self.textView.layer.cornerRadius = 4;
    self.textView.clipsToBounds = YES;
//    self.textView.layer.borderWidth = .5f; //边框宽度
//    self.textView.layer.borderColor = [UIColor colorWithHex:NPBorderColor].CGColor; //边框颜色
    self.textView.layer.cornerRadius = self.textView.tz_height/2;
    self.textView.layer.masksToBounds = true;
    self.textView.returnKeyType =  UIReturnKeySend;
    self.textView.font = [UIFont systemFontOfSize:15.f];
    self.textView.delegate = self;
    [self addSubview:self.textView];
    
    WS(wself)
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.top.mas_equalTo(wself.mas_top).with.offset(0);
        make.right.mas_equalTo(wself.mas_right).with.offset(-10);
        make.bottom.mas_equalTo(wself.mas_bottom).with.offset(0);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wself.mas_left).with.offset(16);
        make.right.mas_equalTo(wself.sendBtn.mas_left).with.offset(-8);
        make.bottom.mas_equalTo(wself.mas_bottom).with.offset(-8);
        make.top.mas_equalTo(wself.mas_top).with.offset(8);
    }];
    
//    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(wself.mas_right).with.offset(-PX_TRANS(30));
//        make.centerY.mas_equalTo(wself.mas_centerY).with.offset(0);
//        make.width.mas_equalTo(PX_TRANS(40));
//        make.height.mas_equalTo(PX_TRANS(40));
//    }];
}

- (void)showViewWithType:(XMFunctionViewShowType)showType {
    switch (showType) {
            
        case XMFunctionViewShowImage:
            
//            [self.textView resignFirstResponder];
//            [self.textView resignFirstResponder];
            
            [self setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight - self.textView.frame.size.height - 10, self.frame.size.width, self.textView.frame.size.height + 10)animated:NO];

            break;
        case XMFunctionViewShowFace:
//            [self.textView resignFirstResponder];
            
            [self setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight - self.textView.frame.size.height - 10, self.frame.size.width, self.textView.frame.size.height + 10) animated:NO];
            
            [self growingTextViewDidChange:self.textView];
            break;
        case XMFunctionViewShowKeyboard:
            [self.textView becomeFirstResponder];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
            break;
        case XMFunctionViewShowMore:
            [self setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight - self.textView.frame.size.height - 10, self.frame.size.width, self.textView.frame.size.height + 10) animated:NO];
            [self growingTextViewDidChange:self.textView];
            
            break;
            
        default:
            break;
    }
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)sendTextMessage:(NSString *)text{
    if (!text || text.length == 0) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendMessage:)]) {
        [self.delegate chatBar:self sendMessage:text];
    }
    self.textView.text = @"";
    [self setFrame:CGRectMake(0, self.superViewHeight - kMinHeight, self.frame.size.width, kMinHeight) animated:NO];
    [self showViewWithType:XMFunctionViewShowKeyboard];
}


//
- (BOOL)growingTextView:(HPGrowingTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [self sendTextMessage:textView.text];
        return NO;
    }else if (text.length == 0){
        //判断删除的文字是否符合表情文字规则
        NSString *deleteText = [textView.text substringWithRange:range];
        if ([deleteText isEqualToString:@"]"]) {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            NSString *subText;
            while (YES) {
                if (location == 0) {
                    return YES;
                }
                location -- ;
                length ++ ;
                subText = [textView.text substringWithRange:NSMakeRange(location, length)];
                if (([subText hasPrefix:@"["] && [subText hasSuffix:@"]"])) {
                    break;
                }
            }
            textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
            [textView setSelectedRange:NSMakeRange(location, 0)];
//            [self textViewDidChange:self.textView];
            return NO;
        }
    }
    return YES;
}
- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView {
    return YES;
}


- (BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView {
    
    return YES;
}


- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView {

}

- (void)faceViewSendFace:(NSString *)faceName{
    if ([faceName isEqualToString:@"[删除]"]) {
        [self growingTextView:self.textView shouldChangeTextInRange:NSMakeRange(self.textView.text.length - 1, 1)  replacementText:@""];
    }else if ([faceName isEqualToString:@"发送"]){
        NSString *text = self.textView.text;
        if (!text || text.length == 0) {
            return;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendMessage:)]) {
            [self.delegate chatBar:self sendMessage:text];
        }
        self.textView.text = @"";
        [self setFrame:CGRectMake(0, self.superViewHeight - kMinHeight, self.frame.size.width, kMinHeight) animated:NO];
        [self showViewWithType:XMFunctionViewShowFace];
    }else{
        self.textView.text = [self.textView.text stringByAppendingString:faceName];
    }

}

-(void)keyboardWillShow:(NSNotification *)note {
    // get keyboard size and loctaion
    self.keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.superview convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect containerFrame = self.frame;
//    NSLog(@"高度多少222:%f",containerFrame.origin.y);
    containerFrame.origin.y = self.superview.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    NSLog(@"高度多少:%f",containerFrame.origin.y);
    // set views with new info
    self.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    self.keyboardFrame = CGRectZero;
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect containerFrame = self.frame;
    containerFrame.origin.y = self.superview.bounds.size.height - containerFrame.size.height;
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    self.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}


- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
//    float textHeight = height>=70.0 ? 70:height;
    float diff = (growingTextView.frame.size.height - height);
    self.r = self.textView.frame;
    _r.size.height -= diff;
    _r.origin.y += diff;
    self.textView.frame = self.r;
    
    CGRect frame = self.frame;
    frame.size.height = self.r.size.height+16;
    frame.origin.y = ScreenHeight-(kStatusBarHeight+44+frame.size.height+_keyboardFrame.size.height);
    self.frame = frame;
}

- (void)setFrame:(CGRect)frame animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:.3 animations:^{
            [self setFrame:frame];
        }];
    }else{
        [self setFrame:frame];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBarFrameDidChange:frame:)]) {
        [self.delegate chatBarFrameDidChange:self frame:frame];
    }
}
- (void)setTz_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (UIViewController *)rootVC {
    return [UIApplication  sharedApplication].keyWindow.rootViewController;
}

- (void)touchDownAnamation:(UIButton* )button{
    button.bounds = CGRectMake(0, 0, 100, 100);
    
    [UIView animateWithDuration:0.25 animations:^{
        button.layer.cornerRadius = 50;
    }];
    
}
-(void)sendBtnClick:(UIButton*)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendBtn:text:)]) {
        [self.delegate chatBar:self sendBtn:sender text:_textView.text];
    }
}

@end
