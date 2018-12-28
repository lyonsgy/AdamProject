//
//  GCPlaceholderTextView.m
//  GCLibrary
//
//  Created by Guillaume Campagna on 10-11-16.
//  Copyright 2010 LittleKiwi. All rights reserved.
//

#import "GCPlaceholderTextView.h"
@interface GCPlaceholderTextView ()
{
    UILabel *placeHolderLabel;
}
@end
@implementation GCPlaceholderTextView
- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame]))
    {
        _limitLength=-1;
        _beyongLimitLengthMessage=nil;
        _isOpenNotification=YES;
        if ( placeHolderLabel == nil )
        {
            placeHolderLabel = [[UILabel alloc] init];
            placeHolderLabel.numberOfLines=0;
            placeHolderLabel.textAlignment=self.textAlignment;
            placeHolderLabel.font = self.font;
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = [UIColor colorWithHex:NPGreyishBrownTwo alpha:.35];
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            [placeHolderLabel setFont:self.font];
            placeHolderLabel.text = self.placeholder;
            [self addSubview:placeHolderLabel];
            WS(wself)
            [placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(5);
                make.top.mas_equalTo(5);
                make.width.mas_equalTo(wself.mas_width).with.offset(-10);
                make.height.mas_greaterThanOrEqualTo(0);
            }];
        }
        self.backgroundColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _limitLength=-1;
    _beyongLimitLengthMessage=nil;
    _isOpenNotification=YES;
    if ( placeHolderLabel == nil )
    {
        placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.numberOfLines=0;
        placeHolderLabel.textAlignment=self.textAlignment;
        placeHolderLabel.font = self.font;
        placeHolderLabel.backgroundColor = [UIColor clearColor];
        placeHolderLabel.textColor = [UIColor colorWithHex:NPGreyishBrownTwo alpha:.35];
        placeHolderLabel.alpha = 0;
        placeHolderLabel.tag = 999;
        [placeHolderLabel setFont:self.font];
        placeHolderLabel.text = self.placeholder;
        [self addSubview:placeHolderLabel];
        WS(wself)
        [placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(5);
            make.width.mas_equalTo(wself.mas_width).with.offset(-10);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
    }
    self.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
}

-(void)setTextLeftMargin:(CGFloat)textLeftMargin
{
    if (placeHolderLabel)
    {
        WS(wself)
        [placeHolderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(textLeftMargin);
            make.top.mas_equalTo(wself.textTopMargin);
            make.width.mas_equalTo(wself.mas_width).with.offset(-10);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
    }
    _textLeftMargin=textLeftMargin;
    [self layoutIfNeeded];
}
-(void)setTextTopMargin:(CGFloat)textTopMargin
{
    if (placeHolderLabel)
    {
        WS(wself)
        [placeHolderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(wself.textLeftMargin);
            make.top.mas_equalTo(textTopMargin);
            make.width.mas_equalTo(wself.mas_width).with.offset(-10);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
    }
    _textTopMargin=textTopMargin;
    [self layoutIfNeeded];
}
-(void)setLimitLength:(NSInteger)limitLength
{
    _limitLength=limitLength;
}
-(void)setBeyongLimitLengthMessage:(NSString *)beyongLimitLengthMessage
{
    _beyongLimitLengthMessage=beyongLimitLengthMessage;
}
-(void)setIsOpenNotification:(BOOL)isOpenNotification
{
    _isOpenNotification=isOpenNotification;
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder=placeholder;
    if(_placeholder)
        placeHolderLabel.text=placeholder;
}
-(void)textFiledEditChanged:(NSNotification *)obj
{
    if(_limitLength==-1)
        return;
    NSString *toBeString = self.text;
    NSInteger dif=toBeString.length-_limitLength;
    NSString *lang;
    if(ABVOEIOS7)
        lang=[self.textInputMode primaryLanguage];
    else
        lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"])
    { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        //UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (selectedRange==nil)
        {
            if (dif>0)
            {
                NSRange selectRange=self.selectedRange;
                NSString *cutStr=[toBeString substringToIndex:_limitLength];
                self.text = cutStr;
                [self setSelectedRange:selectRange];
//                if (_beyongLimitLengthMessage)
//                    DLog(@"超出长度");
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else
        {
           
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (dif>0)
        {
            NSRange selectRange=self.selectedRange;
            NSString *cutStr=[toBeString substringToIndex:_limitLength];
            self.text = cutStr;
            [self setSelectedRange:selectRange];
//            if (_beyongLimitLengthMessage)
//                 DLog(@"超出长度");
        }
    }
}
- (void)textChanged:(NSNotification *)notification
{
    if([[self text] length] == 0)
        [[self viewWithTag:999] setAlpha:1];
    else
        [[self viewWithTag:999] setAlpha:0];
    if (_isOpenNotification)
        [self textFiledEditChanged:notification];
}
-(void)setText:(NSString *)textStr
{
    [super setText:textStr];
    [self textChanged:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutIfNeeded];
}
- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        [placeHolderLabel setAlpha:1];
    }
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
        [[self viewWithTag:999] setAlpha:1];
    if([[self text] length] > 0)
    {
        [[self viewWithTag:999] setAlpha:0];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
