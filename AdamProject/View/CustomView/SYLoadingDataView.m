//
//  SYLoadingDataView.m
//  Jikebaba
//
//  Created by nplus on 15/4/30.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "SYLoadingDataView.h"
#import "Masonry.h"
@implementation SYLoadingDataView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        CGFloat height = (ScreenHeight/2-ScreenWidth/375*211)*2;//保证在中间
        LoadingViewForOC *loadingView = [[LoadingViewForOC alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
        [self addSubview:loadingView];
    }
    return self;
}
@end
