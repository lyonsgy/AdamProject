//
//  NPRefreshAutoGifFooter.h
//  Jikebaba
//
//  Created by lyons on 2017/5/31.
//  Copyright © 2017年 NewZhiWei. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>
#import "../../View/DGActivityIndicatorView/DGActivityIndicatorView.h"

@interface NPRefreshAutoGifFooter : MJRefreshAutoGifFooter
@property (nonatomic,strong)UIView *endPageView;
@property (nonatomic,strong)DGActivityIndicatorView *loadingView;
@end
