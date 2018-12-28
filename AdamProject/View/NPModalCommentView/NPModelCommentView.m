//
//  NPModelCommentView.m
//  Jikebaba
//
//  Created by NPlus on 2016/12/16.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import "NPModelCommentView.h"

@interface NPModelCommentView ()<UITextViewDelegate>

@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIWindow *commentWindow;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *limitLabel;
@end

@implementation NPModelCommentView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:CGRectMake(0, ScreenHeight-200, ScreenWidth, 200)];
    if(self)
    {
        [self setCustomView];
    }
    return self;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_commentWindow resignKeyWindow];
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
    [_cancelBtn setFrame:CGRectMake(ScreenWidth-40, 0, 40, 40)];
    [_commentTextView setFrame:CGRectMake(0, 35, ScreenWidth, 125)];
    [_commitBtn setFrame:CGRectMake(ScreenWidth-150, 160, 150, 40)];
}
-(void)setCustomView{
    _commentWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _commentWindow.windowLevel = UIWindowLevelAlert;
//    _commentWindow.rootViewController = self;
    _commentWindow.backgroundColor = [UIColor blackColorWithHexAlpha:178];
    [_commentWindow makeKeyAndVisible];
    [_commentWindow setHidden:YES];
    
    //评论背景View
    self.backgroundColor = [UIColor colorWithHex:0xffffff];
    [_commentWindow addSubview:self];
    
    //关闭
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_cancelBtn];
    [_cancelBtn setImage:[UIImage imageNamed:@"icon_取消点评"] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //文字点评title
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(38, 0, 60, 35)];
    [self addSubview:commentLabel];
    commentLabel.text = @"文字点评";
    commentLabel.textColor = [UIColor colorWithHex:NPGreyishBrownTwo alpha:.87];
    commentLabel.font = [UIFont systemFontOfSize:14];
    commentLabel.textAlignment = NSTextAlignmentCenter;
    
    //输入textView
    _commentTextView = [GCPlaceholderTextView new];
    [self addSubview:_commentTextView];
    _commentTextView.placeholder=@"148字以内";
    _commentTextView.delegate = self;
    _commentTextView.limitLength=148;
    _commentTextView.backgroundColor = [UIColor colorWithHex:0xffffff];
    [_commentTextView setFont:[UIFont systemFontOfSize:14]];
    
    //点评imageView
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 16, 14)];
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"icon_信息"];
    
    //底部View
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 160, ScreenWidth, 40)];
    [self addSubview:bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.borderWidth = 0.5f; //边框宽度
    bottomView.layer.borderColor = [[UIColor colorWithHex:0xbecbd1]CGColor]; //边框颜色
    
    //limitLengthLabel
    _limitLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 200, 40)];
    [bottomView addSubview:_limitLabel];
    _limitLabel.font = [UIFont systemFontOfSize:12];
    _limitLabel.textColor = [UIColor colorWithHex:NPGreyishBrownTwo alpha:.35];
    _limitLabel.text = @"字数限制:0/148";
    
    //确定提交
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_commitBtn];
    [_commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_commitBtn setBackgroundImageWithHexs:@[@"0x86af49",@"0xbfd158",@"0x8c8c8c"] andStateArray:@[@"nor",@"pre",@"dis"]];
    [_commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _commitBtn.enabled=NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)cancelBtnClick:(id)sender{
    [_commentWindow setHidden:YES];
//    _commentTextView.text = @"";
    [_commentTextView resignFirstResponder];
    if ([_commentTextView.text removeWhitespaceAndNewline].length)
    {
        [_commentBtn setTitle:[_commentTextView.text removeWhitespaceAndNewline] forState:UIControlStateNormal];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancellBtnIsClick)])
    {
        [self.delegate cancellBtnIsClick];
    }
}

-(void)commitBtnClick:(id)sender{
    //提交
    [_commentWindow setHidden:YES];
    [_commentTextView resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(makeSureBtnClick:)])
    {
        [self.delegate makeSureBtnClick:self.commentTextView.text];
    }
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary * info=[aNotification userInfo];
    CGFloat keyboardAppearTime=[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGRect frame = self.frame;
    if (frame.origin.y+frame.size.height>ScreenHeight-keyboardRect.size.height)
    {
        [UIView animateWithDuration:keyboardAppearTime animations:^{
            self.frame=CGRectMake(frame.origin.x, ScreenHeight-keyboardRect.size.height-frame.size.height, frame.size.width, frame.size.height);
        }];
    }
}
//当键退出时调用
-(void)keyboardWillHide:(NSNotification *)aNotification
{
    NSDictionary * info=[aNotification userInfo];
    CGFloat keyboardAppearTime=[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect frame = self.frame;
    if (frame.origin.y!=(ScreenHeight-frame.size.height))
    {
        [UIView animateWithDuration:keyboardAppearTime animations:^{
            self.frame=CGRectMake(frame.origin.x, ScreenHeight-172, frame.size.width, frame.size.height);
        }];
    }
}
#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text removeWhitespaceAndNewline].length)
    {
        //解禁提交按钮
        _commitBtn.enabled=YES;
        if ([textView.text removeWhitespaceAndNewline].length>148) {
            _limitLabel.text = [NSString stringWithFormat:@"字数限制:148/148"];
        }else{
            _limitLabel.text = [NSString stringWithFormat:@"字数限制:%lu/148",(unsigned long)[textView.text removeWhitespaceAndNewline].length];
        }
    }
    else
    {   //禁用提交按钮
        _commitBtn.enabled=NO;
        _limitLabel.text = [NSString stringWithFormat:@"字数限制:0/148"];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentViewDidChange:)])
    {
        [self.delegate commentViewDidChange:textView.text];
    }
}
#pragma mark - Action
- (void)showCommentView{
    [_commentWindow makeKeyAndVisible];
    [_commentWindow setHidden:NO];
    [_commentTextView becomeFirstResponder];
}
- (void)hideCommentView{
    [_commentWindow setHidden:YES];
    [_commentTextView resignFirstResponder];
    if ([_commentTextView.text removeWhitespaceAndNewline].length)
    {
        [_commentBtn setTitle:[_commentTextView.text removeWhitespaceAndNewline] forState:UIControlStateNormal];
    }
}
-(void)resetCommentView{
    _commentTextView.text = @"";
    _limitLabel.text = [NSString stringWithFormat:@"字数限制:0/148"];
}
-(void)removeCommentView{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_commentWindow resignKeyWindow];
    _commentWindow = nil;
}
@end
