//
//  SYStackView.m
//  MSGZS
//
//  Created by nplus on 16/1/5.
//  Copyright © 2016年 Syousoft. All rights reserved.
//

#import "SYStackView.h"
#import "Masonry.h"
#import "UIView+Helper.h"

@interface SYStackView ()
@property (nonatomic,assign)UIEdgeInsets separateLineOffset;
@end

@implementation SYStackView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        _uplineView=[UIView new];
        [self addSubview:_uplineView];
        [_uplineView setBackgroundColor:[UIColor grayColor]];
        [_uplineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.top.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        _isShowSeparateLine =YES;
        _separateLineColor=[UIColor grayColor];
        _separateLineOffset = UIEdgeInsetsMake(9, 0, 9, 0);
        _separateLineArray=[NSMutableArray array];
    }
    return self;
}
-(void)addStackViews:(NSArray *)views
{
    [self addSubviews:views];
    UIView *first =views.firstObject;
    if(views.count==1)
    {
        [first mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }else
    {
        NSArray *subArray=[views subarrayWithRange:NSMakeRange(1, views.count-1)];
        [first mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(subArray);
            make.left.and.top.mas_equalTo(0);
            make.height.equalTo(self.mas_height);
            make.height.equalTo(subArray);
            make.top.equalTo(subArray);
        }];
        UIView *preView =first;
        for (int i=0; i<subArray.count; i++) {
            UIView *aitem=subArray[i];
            
            //separateLine
            UIView *aseparateLine=[UIView new];
            [self addSubview:aseparateLine];
            if(_isShowSeparateLine)
                [aseparateLine setHidden:YES];
            [_separateLineArray addObject:aseparateLine];
            [aseparateLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preView.mas_right).offset(_separateLineOffset.left);
                make.top.equalTo(self.mas_top).offset(_separateLineOffset.top);
                make.bottom.equalTo(self.mas_bottom).offset(-_separateLineOffset.bottom);
                make.width.mas_equalTo(1);
            }];
        
            if(i==(subArray.count-1))
            {
                [aitem mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(preView.mas_right);
                    make.right.mas_equalTo(0);
                }];
            }else
            {
                [aitem mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(preView.mas_right);
                }];
            }
            preView=aitem;
        }
        
    }
    
    [self bringSubviewToFront:_uplineView];
}
-(void)setIsShowSeparateLine:(BOOL)isShowSeparateLine
{
    _isShowSeparateLine=isShowSeparateLine;
    for (UIView *view in _separateLineArray) {
        [view setHidden:!_isShowSeparateLine];
    }
    
}
-(void)setSeparateLineColor:(UIColor *)separateLineColor
{
    _separateLineColor=separateLineColor;
    for (UIView *view in _separateLineArray) {
        [view setBackgroundColor:separateLineColor];
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
