//
//  SYStarView.m
//  123456
//
//  Created by Syousoft2 on 16/4/5.
//  Copyright © 2016年 Syousoft2. All rights reserved.
//

#import "SYStarView.h"
#define DefaultStarWidth 25
#define DefaultLeftMargin 3
@implementation SYStarButton

@end

@implementation SYStarView
{
    SYStarButton *_firstButton;
    SYStarButton *_secondButton;
    SYStarButton *_thirdButton;
    SYStarButton *_fourthButton;
    SYStarButton *_fifthButton;
    UIView *_topView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        _firstButton=[SYStarButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_firstButton];
        
        _secondButton=[SYStarButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_secondButton];
        
        _thirdButton=[SYStarButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_thirdButton];
        
        _fourthButton=[SYStarButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_fourthButton];
        
        _fifthButton=[SYStarButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_fifthButton];
        NSArray *buttonsArray=@[_firstButton,_secondButton,_thirdButton,_fourthButton,_fifthButton];
        _enabled=YES;
        
        WS(wself)
        for (NSInteger i=0;i<buttonsArray.count;i++)
        {
            SYStarButton * currentButton=buttonsArray[i];
            currentButton.index=i;
            [currentButton setImage:[UIImage imageNamed:@"star_nor"] forState:UIControlStateNormal];
            [currentButton setImage:[UIImage imageNamed:@"star_sel"] forState:UIControlStateSelected];
            [currentButton addTarget:self action:@selector(starButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i==0)
            {
                [currentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.mas_equalTo(0);
                    make.centerY.mas_equalTo(wself.mas_centerY).with.offset(0);
                    make.width.mas_equalTo(DefaultStarWidth);
                    make.height.mas_equalTo(DefaultStarWidth);
                }];
            }
            else
            {
                SYStarButton * preButton=buttonsArray[i-1];
                [currentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(preButton.mas_right).with.offset(DefaultLeftMargin);
                    make.centerY.mas_equalTo(wself.mas_centerY).with.offset(0);
                    make.width.mas_equalTo(DefaultStarWidth);
                    make.height.mas_equalTo(DefaultStarWidth);
                }];
            }
            
        }
        _topView=[[UIView alloc]init];
        _topView.backgroundColor=[UIColor clearColor];
        _topView.hidden=YES;
        [self addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(wself).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame withStarWidth:(CGFloat)starWidth withLeftMargin:(CGFloat)leftMargin
{
    self=[self initWithFrame:frame];
    if (self)
    {
        NSArray *buttonsArray=@[_firstButton,_secondButton,_thirdButton,_fourthButton,_fifthButton];
        for (NSInteger i=0;i<buttonsArray.count;i++)
        {
            SYStarButton * currentButton=buttonsArray[i];
            
            if (i==0)
            {
                [currentButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.leading.mas_equalTo(0);
                    //make.centerY.mas_equalTo(wself.mas_centerY).with.offset(0);
                    make.width.mas_equalTo(starWidth);
                    make.height.mas_equalTo(starWidth);
                }];
            }
            else
            {
                SYStarButton * preButton=buttonsArray[i-1];
                [currentButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(preButton.mas_right).with.offset(leftMargin);
                    //make.centerY.mas_equalTo(wself.mas_centerY).with.offset(0);
                    make.width.mas_equalTo(starWidth);
                    make.height.mas_equalTo(starWidth);
                }];
            }
            
        }
    }
    return self;
}
#pragma mark get
#pragma mark set
-(void)setEnabled:(BOOL)enabled
{
    _enabled=enabled;
    _topView.hidden=enabled;
    
}
-(void)setScore:(NSInteger)score
{
    _score=score;
     NSArray *buttonsArray=@[_firstButton,_secondButton,_thirdButton,_fourthButton,_fifthButton];
    for (NSInteger i=0;i<buttonsArray.count;i++)
    {
        SYStarButton *button=buttonsArray[i];
        if (score>i)
        {
            button.selected=YES;
            
        }
        else
        {
            button.selected=NO;
        }
    }
    
}
-(void)starButtonClick:(SYStarButton*)starButton
{
    if (starButton.selected)
    {
        self.score=starButton.index;
    }
    else
    {
        self.score=starButton.index+1;
    }
    
}
@end
