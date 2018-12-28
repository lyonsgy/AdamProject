//
//  UIViewController+AddSubView.m
//  Jikebaba
//
//  Created by nplus on 15/4/27.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "UIViewController+AddSubView.h"
#import "Masonry.h"
@implementation UIViewController (AddSubView)
ADD_DYNAMIC_PROPERTY(SYNoDataShowView *, nodataView, setNodataView);
ADD_DYNAMIC_PROPERTY(SYNoDataShowView *, nodataView1, setNodataView1);
ADD_DYNAMIC_PROPERTY(SYNoDataShowView *, nodataView2, setNodataView2);
ADD_DYNAMIC_PROPERTY(SYLoadingDataView *, loadDataView, setLoadDataView);
ADD_DYNAMIC_PROPERTY(SYNetworkErrorView *, networkErrorView, setNetworkErrorView);
ADD_DYNAMIC_PROPERTY(SYNetworkErrorView *, networkErrorView1, setNetworkErrorView1);
ADD_DYNAMIC_PROPERTY(SYNetworkErrorView *, networkErrorView2, setNetworkErrorView2);
ADD_DYNAMIC_PROPERTY(SYNetworkErrorView *, loginView, setLoginView);
ADD_DYNAMIC_PROPERTY(SYControl *, maskView, setMaskView);
ADD_DYNAMIC_PROPERTY_COPY(buttonHandler, handler, setHandler);
ADD_DYNAMIC_PROPERTY_COPY(loginhandle, loginHandler, setLoginHandler);

-(void)hideAllAlertView
{
    [self hideLoadingDataView];
    [self hideNetWorkErrorView];
    [self hideNodateView];
    [self hideloginView];
    if(self.maskView)
        [self.maskView removeFromSuperview];
    [self.nodataView1.superview sendSubviewToBack:self.nodataView1];
    [self.nodataView1 removeFromSuperview];
    [self.nodataView1 setHidden:YES];
    [self.networkErrorView1.superview sendSubviewToBack:self.networkErrorView1];
    [self.networkErrorView1 removeFromSuperview];
    [self.networkErrorView1 setHidden:YES];
    [self.nodataView2.superview sendSubviewToBack:self.nodataView2];
    [self.nodataView2 removeFromSuperview];
    [self.nodataView2 setHidden:YES];
    [self.networkErrorView2.superview sendSubviewToBack:self.networkErrorView2];
    [self.networkErrorView2 removeFromSuperview];
    [self.networkErrorView2 setHidden:YES];
}
-(void)hideWillAlertView{
    [self hideLoadingDataView];
    [self hideloginView];
    if(self.maskView)
        [self.maskView removeFromSuperview];
    [self.nodataView1.superview sendSubviewToBack:self.nodataView1];
    [self.nodataView1 removeFromSuperview];
    [self.nodataView1 setHidden:YES];
    [self.networkErrorView1.superview sendSubviewToBack:self.networkErrorView1];
    [self.networkErrorView1 removeFromSuperview];
    [self.networkErrorView1 setHidden:YES];
}
-(void)hideHasAlertView{
    [self hideLoadingDataView];
    if(self.maskView)
        [self.maskView removeFromSuperview];
    [self.nodataView2.superview sendSubviewToBack:self.nodataView2];
    [self.nodataView2 removeFromSuperview];
    [self.nodataView2 setHidden:YES];
    [self.networkErrorView2.superview sendSubviewToBack:self.networkErrorView2];
    [self.networkErrorView2 removeFromSuperview];
    [self.networkErrorView2 setHidden:YES];
}
#pragma mark ---NOdataView----
-(void)addNOdataViewWithImage:(UIImage *)image
                     AndTitle:(NSString *)title
                  AndSubTitle:(NSString *)subTitle
{
    self.nodataView =[[SYNoDataShowView alloc]initWithFrame:CGRectZero];
    [self.nodataView.showImage setImage:image];
    [self.nodataView.showLabel setText:title];
    [self.nodataView.showSubLabel setText:subTitle];
    self.nodataView1 =[[SYNoDataShowView alloc]initWithFrame:CGRectZero];
    [self.nodataView1.showImage setImage:image];
    [self.nodataView1.showLabel setText:title];
    [self.nodataView1.showSubLabel setText:subTitle];
    self.nodataView2 =[[SYNoDataShowView alloc]initWithFrame:CGRectZero];
    [self.nodataView2.showImage setImage:image];
    [self.nodataView2.showLabel setText:title];
    [self.nodataView2.showSubLabel setText:subTitle];
}

-(void)hideNodateView
{
    if(self.maskView)
        [self.maskView removeFromSuperview];
    [self.nodataView.superview sendSubviewToBack:self.nodataView];
    [self.nodataView removeFromSuperview];
    [self.nodataView setHidden:YES];
    [self.nodataView1.superview sendSubviewToBack:self.nodataView1];
    [self.nodataView1 removeFromSuperview];
    [self.nodataView1 setHidden:YES];
    [self.nodataView2.superview sendSubviewToBack:self.nodataView2];
    [self.nodataView2 removeFromSuperview];
    [self.nodataView2 setHidden:YES];
}

-(void)showNodataView
{
    [self ShowNOdataViewFromSuperView:self.view];
}
-(void)ShowNOdataViewFromSuperView:(UIView *)superView
{
    [self ShowNOdataViewFromSuperView:superView AndEdageOffSet:UIEdgeInsetsZero];
}
//添加老师
-(void)ShowHomeworkNOdataViewFromSuperView:(UIView *)asuperView
                       NOdataTitle:(NSString *)NOdataTitle
                       NOdataImage:(UIImage *)NOdataImage
                    AndEdageOffSet:(UIEdgeInsets)offset{
    UIView *superView=asuperView;
    if([asuperView isKindOfClass:[UITableView class]])
    {
        if(!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            if(self.maskView==nil)
            {
                self.maskView=[[SYControl alloc]initWithFrame:CGRectMake(0,0, superView.frame.size.width, superView.frame.size.height)];
                [self.maskView setBackgroundColor:[UIColor clearColor]];
                [self.maskView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            }
            [superView addSubview:self.maskView];
            superView=self.maskView;
        }
    }
    UIView *nodataView = [UIView new];
    [nodataView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *showImage=[UIImageView new];
    [showImage setImage:NOdataImage];
    UILabel *showLabel=[UILabel new];
    [showLabel setTextColor:[UIColor colorWithHex:0xbbb8bb]];
    [showLabel setFont:[UIFont systemFontOfSize:15]];
    showLabel.text = NOdataTitle;
    
    UILabel *showSubLabel=[UILabel new];
    [showSubLabel setTextColor:[UIColor colorWithHex:0x565151]];
    [showSubLabel setFont:[UIFont systemFontOfSize:13]];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"icon_添加"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [superView addSubview:nodataView];
    [nodataView addSubview:showImage];
    [nodataView addSubview:showLabel];
    [nodataView addSubview:showSubLabel];
    [nodataView addSubview:addButton];
    
    WeakObject(superView, wSuperView)
    [showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.equalTo(showImage.mas_width).multipliedBy(1);
        make.centerX.equalTo(wSuperView);
        make.centerY.equalTo(wSuperView);
    }];
    
    showLabel.numberOfLines=0;
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@[showImage,showSubLabel]);
        make.height.mas_greaterThanOrEqualTo(0);
        make.width.mas_lessThanOrEqualTo(300);
        make.top.equalTo(showImage.mas_bottom).with.offset(15);
    }];
    
    showSubLabel.numberOfLines=0;
    [showSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showLabel.mas_bottom).with.offset(15);
        make.height.mas_greaterThanOrEqualTo(0);
        make.width.mas_lessThanOrEqualTo(300);
    }];
    
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showLabel.mas_bottom).with.offset(12);
        make.height.mas_offset(44);
        make.width.mas_offset(150);
    }];
    
    if([superView isKindOfClass:[UIScrollView class]])
    {
        [nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSuperView.mas_left).with.offset(offset.left);
            make.right.equalTo(wSuperView.mas_right).with.offset(-offset.right);
            make.top.equalTo(wSuperView.mas_top).with.offset(offset.top);
            make.bottom.equalTo(wSuperView.mas_bottom).with.offset(-offset.bottom);
            make.width.equalTo(wSuperView.mas_width).with.offset(-offset.left-offset.right);
            make.height.equalTo(wSuperView.mas_height).with.offset(-offset.top-offset.bottom);
        }];
    }else
    {
        [nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wSuperView).insets(offset);
        }];
    }
    
    [wSuperView bringSubviewToFront:nodataView];
    [nodataView setHidden:NO];
}
-(void)addButtonClick:(id)sender{

}
-(void)ShowWillNOdataViewFromSuperView:(UIView *)asuperView
                           NOdataTitle:(NSString *)NOdataTitle
                           NOdataImage:(UIImage *)NOdataImage
                        AndEdageOffSet:(UIEdgeInsets)offset
{
    UIView *superView=asuperView;
    self.nodataView1.backgroundColor = [UIColor colorWithHex:NPBackgroundColor];
    self.nodataView1.showImage.image = NOdataImage;
    self.nodataView1.showLabel.text = NOdataTitle;
    if([asuperView isKindOfClass:[UITableView class]])
    {
        if(!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            if(self.maskView==nil)
            {
                self.maskView=[[SYControl alloc]initWithFrame:CGRectMake(0,0, superView.frame.size.width, superView.frame.size.height)];
                [self.maskView setBackgroundColor:[UIColor clearColor]];
                [self.maskView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            }
            [superView addSubview:self.maskView];
            superView=self.maskView;
        }
    }
    [superView addSubview:self.nodataView1];
    WeakObject(superView, wSuperView)
    if([superView isKindOfClass:[UIScrollView class]])
    {
        [self.nodataView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSuperView.mas_left).with.offset(offset.left);
            make.right.equalTo(wSuperView.mas_right).with.offset(-offset.right);
            make.top.equalTo(wSuperView.mas_top).with.offset(offset.top);
            make.bottom.equalTo(wSuperView.mas_bottom).with.offset(-offset.bottom);
            make.width.equalTo(wSuperView.mas_width).with.offset(-offset.left-offset.right);
            make.height.equalTo(wSuperView.mas_height).with.offset(-offset.top-offset.bottom);
        }];
    }else
    {
        [self.nodataView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wSuperView).insets(offset);
        }];
    }
    
    [wSuperView bringSubviewToFront:self.nodataView1];
    [self.nodataView1 setHidden:NO];
}
-(void)ShowHasNOdataViewFromSuperView:(UIView *)asuperView
                       NOdataTitle:(NSString *)NOdataTitle
                       NOdataImage:(UIImage *)NOdataImage
                    AndEdageOffSet:(UIEdgeInsets)offset
{
    self.nodataView2.backgroundColor = [UIColor colorWithHex:NPBackgroundColor];
    self.nodataView2.showImage.image = NOdataImage;
    self.nodataView2.showLabel.text = NOdataTitle;
    UIView *superView=asuperView;
    if([asuperView isKindOfClass:[UITableView class]])
    {
        if(!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            if(self.maskView==nil)
            {
                self.maskView=[[SYControl alloc]initWithFrame:CGRectMake(0,0, superView.frame.size.width, superView.frame.size.height)];
                [self.maskView setBackgroundColor:[UIColor clearColor]];
                [self.maskView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            }
            [superView addSubview:self.maskView];
            superView=self.maskView;
        }
    }
    [superView addSubview:self.nodataView2];
    WeakObject(superView, wSuperView)
    if([superView isKindOfClass:[UIScrollView class]])
    {
        [self.nodataView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSuperView.mas_left).with.offset(offset.left);
            make.right.equalTo(wSuperView.mas_right).with.offset(-offset.right);
            make.top.equalTo(wSuperView.mas_top).with.offset(offset.top);
            make.bottom.equalTo(wSuperView.mas_bottom).with.offset(-offset.bottom);
            make.width.equalTo(wSuperView.mas_width).with.offset(-offset.left-offset.right);
            make.height.equalTo(wSuperView.mas_height).with.offset(-offset.top-offset.bottom);
        }];
    }else
    {
        [self.nodataView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wSuperView).insets(offset);
        }];
    }
    
    [wSuperView bringSubviewToFront:self.nodataView2];
    [self.nodataView2 setHidden:NO];
}
-(void)ShowNOdataViewFromSuperView:(UIView *)asuperView
                       NOdataTitle:(NSString *)NOdataTitle
                       NOdataImage:(UIImage *)NOdataImage
                    AndEdageOffSet:(UIEdgeInsets)offset
{
    UIView *superView=asuperView;
    self.nodataView.showImage.image = NOdataImage;
    self.nodataView.showLabel.text = NOdataTitle;
    if([asuperView isKindOfClass:[UITableView class]])
    {
        if(!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            if(self.maskView==nil)
            {
                self.maskView=[[SYControl alloc]initWithFrame:CGRectMake(0,0, superView.frame.size.width, superView.frame.size.height)];
                [self.maskView setBackgroundColor:[UIColor clearColor]];
                [self.maskView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            }
            [superView addSubview:self.maskView];
            superView=self.maskView;
        }
    }
    [superView addSubview:self.nodataView];
    WeakObject(superView, wSuperView)
    if([superView isKindOfClass:[UIScrollView class]])
    {
        [self.nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSuperView.mas_left).with.offset(offset.left);
            make.right.equalTo(wSuperView.mas_right).with.offset(-offset.right);
            make.top.equalTo(wSuperView.mas_top).with.offset(offset.top);
            make.bottom.equalTo(wSuperView.mas_bottom).with.offset(-offset.bottom);
            make.width.equalTo(wSuperView.mas_width).with.offset(-offset.left-offset.right);
            make.height.equalTo(wSuperView.mas_height).with.offset(-offset.top-offset.bottom);
        }];
    }else
    {
        [self.nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wSuperView).insets(offset);
        }];
    }
    
    [wSuperView bringSubviewToFront:self.nodataView];
    [self.nodataView setHidden:NO];
}
-(void)ShowNOdataViewFromSuperView:(UIView *)asuperView
                    AndEdageOffSet:(UIEdgeInsets)offset
{
    UIView *superView=asuperView;
    if([asuperView isKindOfClass:[UITableView class]])
    {
        if(!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            if(self.maskView==nil)
            {
                self.maskView=[[SYControl alloc]initWithFrame:CGRectMake(0,0, superView.frame.size.width, superView.frame.size.height)];
                [self.maskView setBackgroundColor:[UIColor clearColor]];
                [self.maskView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            }
            [superView addSubview:self.maskView];
            superView=self.maskView;
        }
    }
    [superView addSubview:self.nodataView];
    WeakObject(superView, wSuperView)
    if([superView isKindOfClass:[UIScrollView class]])
    {
        [self.nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSuperView.mas_left).with.offset(offset.left);
            make.right.equalTo(wSuperView.mas_right).with.offset(-offset.right);
            make.top.equalTo(wSuperView.mas_top).with.offset(offset.top);
            make.bottom.equalTo(wSuperView.mas_bottom).with.offset(-offset.bottom);
            make.width.equalTo(wSuperView.mas_width).with.offset(-offset.left-offset.right);
            make.height.equalTo(wSuperView.mas_height).with.offset(-offset.top-offset.bottom);
        }];
    }else
    {
        [self.nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wSuperView).insets(offset);
        }];
    }
    
    [wSuperView bringSubviewToFront:self.nodataView];
    [self.nodataView setHidden:NO];
    
}
#pragma mark ---NetworkErrorView----
-(void)showNetWorkErrorViewWithReloadBlock:(void(^)(UIButton *sender))reloadBlock
{
    [self ShowNetWorkErrorViewFromSuperView:self.view WithReloadBlock:reloadBlock];
}

-(void)addNetWorkErrorViewWithImage:(UIImage *)image Title:(NSString *)title
{
    self.networkErrorView =[[SYNetworkErrorView alloc]initWithFrame:CGRectZero];
    [self.networkErrorView.showLabel setText:title];
    [self.networkErrorView.showImage setImage:image];
    [self.networkErrorView.operationButton addTarget:self action:@selector(reloadData:) forControlEvents:UIControlEventTouchUpInside];
    self.networkErrorView1 =[[SYNetworkErrorView alloc]initWithFrame:CGRectZero];
    self.networkErrorView1.backgroundColor = [UIColor colorWithHex:NPBackgroundColor];
    [self.networkErrorView1.showLabel setText:title];
    [self.networkErrorView1.showImage setImage:image];
    [self.networkErrorView1.operationButton addTarget:self action:@selector(reloadData:) forControlEvents:UIControlEventTouchUpInside];
    self.networkErrorView2 =[[SYNetworkErrorView alloc]initWithFrame:CGRectZero];
    self.networkErrorView2.backgroundColor = [UIColor colorWithHex:NPBackgroundColor];
    [self.networkErrorView2.showLabel setText:title];
    [self.networkErrorView2.showImage setImage:image];
    [self.networkErrorView2.operationButton addTarget:self action:@selector(reloadData:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)hideNetWorkErrorView
{
    if(self.maskView)
        [self.maskView removeFromSuperview];
    [self.networkErrorView.superview sendSubviewToBack:self.networkErrorView];
    [self.networkErrorView removeFromSuperview];
    [self.networkErrorView setHidden:YES];
}
-(void)ShowNetWorkErrorViewFromSuperView:(UIView *)superView WithReloadBlock:(void(^)(UIButton *sender))reloadBlock
{
    [self ShowNetWorkErrorViewFromSuperView:superView AndEdageOffSet:UIEdgeInsetsZero WithReloadBlock:reloadBlock];
}
-(void)ShowNetWorkErrorViewFromSuperView:(UIView *)asuperView
                          AndEdageOffSet:(UIEdgeInsets)offset
                         WithReloadBlock:(void(^)(UIButton *sender))reloadBlock
{
    UIView *superView=asuperView;
    if([asuperView isKindOfClass:[UITableView class]])
    {
        if(!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            if(self.maskView==nil)
            {
                self.maskView=[[SYControl alloc]initWithFrame:CGRectMake(0,0, superView.frame.size.width, superView.frame.size.height)];
                [self.maskView setBackgroundColor:[UIColor clearColor]];
                [self.maskView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            }
            [self.networkErrorView.operationButton setEnabled:YES];
            [superView addSubview:self.maskView];
            superView=self.maskView;
        }
    }
    
    [superView addSubview:self.networkErrorView];
    WeakObject(superView, wSuperView)
    if([superView isKindOfClass:[UIScrollView class]])
    {
        [self.networkErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSuperView.mas_left).with.offset(offset.left);
            make.right.equalTo(wSuperView.mas_right).with.offset(-offset.right);
            make.top.equalTo(wSuperView.mas_top).with.offset(offset.top);
            make.bottom.equalTo(wSuperView.mas_bottom).with.offset(-offset.bottom);
            make.width.equalTo(wSuperView.mas_width).with.offset(-offset.left-offset.right);
            make.height.equalTo(wSuperView.mas_height).with.offset(-offset.top-offset.bottom);
        }];
    }else
    {
        [self.networkErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wSuperView).insets(offset);
        }];
    }
    
    self.handler=reloadBlock;
    [superView bringSubviewToFront:self.networkErrorView];
    [self.networkErrorView setHidden:NO];
}
-(void)ShowWillNetWorkErrorViewFromSuperView:(UIView *)asuperView
                           AndEdageOffSet:(UIEdgeInsets)offset
                          WithReloadBlock:(void(^)(UIButton *sender))reloadBlock
{
    UIView *superView=asuperView;
    if([asuperView isKindOfClass:[UITableView class]])
    {
        if(!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            if(self.maskView==nil)
            {
                self.maskView=[[SYControl alloc]initWithFrame:CGRectMake(0,0, superView.frame.size.width, superView.frame.size.height)];
                [self.maskView setBackgroundColor:[UIColor clearColor]];
                [self.maskView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            }
            [self.networkErrorView1.operationButton setEnabled:YES];
            [superView addSubview:self.maskView];
            superView=self.maskView;
        }
    }
    
    [superView addSubview:self.networkErrorView1];
    WeakObject(superView, wSuperView)
    if([superView isKindOfClass:[UIScrollView class]])
    {
        [self.networkErrorView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSuperView.mas_left).with.offset(offset.left);
            make.right.equalTo(wSuperView.mas_right).with.offset(-offset.right);
            make.top.equalTo(wSuperView.mas_top).with.offset(offset.top);
            make.bottom.equalTo(wSuperView.mas_bottom).with.offset(-offset.bottom);
            make.width.equalTo(wSuperView.mas_width).with.offset(-offset.left-offset.right);
            make.height.equalTo(wSuperView.mas_height).with.offset(-offset.top-offset.bottom);
        }];
    }else
    {
        [self.networkErrorView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wSuperView).insets(offset);
        }];
    }
    
    self.handler=reloadBlock;
    [superView bringSubviewToFront:self.networkErrorView1];
    [self.networkErrorView1 setHidden:NO];
}
-(void)ShowHasNetWorkErrorViewFromSuperView:(UIView *)asuperView
                          AndEdageOffSet:(UIEdgeInsets)offset
                         WithReloadBlock:(void(^)(UIButton *sender))reloadBlock
{
    UIView *superView=asuperView;
    if([asuperView isKindOfClass:[UITableView class]])
    {
        if(!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            if(self.maskView==nil)
            {
                self.maskView=[[SYControl alloc]initWithFrame:CGRectMake(0,0, superView.frame.size.width, superView.frame.size.height)];
                [self.maskView setBackgroundColor:[UIColor clearColor]];
                [self.maskView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            }
            [self.networkErrorView2.operationButton setEnabled:YES];
            [superView addSubview:self.maskView];
            superView=self.maskView;
        }
    }
    
    [superView addSubview:self.networkErrorView2];
    WeakObject(superView, wSuperView)
    if([superView isKindOfClass:[UIScrollView class]])
    {
        [self.networkErrorView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSuperView.mas_left).with.offset(offset.left);
            make.right.equalTo(wSuperView.mas_right).with.offset(-offset.right);
            make.top.equalTo(wSuperView.mas_top).with.offset(offset.top);
            make.bottom.equalTo(wSuperView.mas_bottom).with.offset(-offset.bottom);
            make.width.equalTo(wSuperView.mas_width).with.offset(-offset.left-offset.right);
            make.height.equalTo(wSuperView.mas_height).with.offset(-offset.top-offset.bottom);
        }];
    }else
    {
        [self.networkErrorView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wSuperView).insets(offset);
        }];
    }
    
    self.handler=reloadBlock;
    [superView bringSubviewToFront:self.networkErrorView2];
    [self.networkErrorView2 setHidden:NO];
}

#pragma mark ---LoginView----
-(void)addloginViewWithTitle:(NSString *)title
{
    self.loginView =[[SYNetworkErrorView alloc]initWithFrame:CGRectZero];
    [self.loginView.showLabel setText:title];
    [self.loginView.operationButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.operationButton setTitle:@"马上登录" forState:UIControlStateNormal];
}
-(void)showloginViewWithReloadBlock:(void(^)(UIButton *sender))reloadBlock
{
    [self ShowloginViewFromSuperView:self.view WithReloadBlock:reloadBlock];
}
-(void)hideloginView
{
    if(self.maskView)
        [self.maskView removeFromSuperview];
    [self.loginView.superview sendSubviewToBack:self.loginView];
    [self.loginView removeFromSuperview];
    [self.loginView setHidden:YES];
}
-(void)ShowloginViewFromSuperView:(UIView *)superView WithReloadBlock:(void(^)(UIButton *sender))reloadBlock
{
    [self ShowloginViewFromSuperView:superView AndEdageOffSet:UIEdgeInsetsZero WithReloadBlock:reloadBlock];
}
-(void)ShowloginViewFromSuperView:(UIView *)asuperView
                   AndEdageOffSet:(UIEdgeInsets)offset
                  WithReloadBlock:(void(^)(UIButton *sender))reloadBlock
{
    UIView *superView=asuperView;
    if([asuperView isKindOfClass:[UITableView class]])
    {
        if(!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            if(self.maskView==nil)
            {
                self.maskView=[[SYControl alloc]initWithFrame:CGRectMake(0,0, superView.frame.size.width, superView.frame.size.height)];
                [self.maskView setBackgroundColor:[UIColor clearColor]];
                [self.maskView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            }
            [self.loginView.operationButton setEnabled:YES];
            [superView addSubview:self.maskView];
            superView=self.maskView;
        }
    }
    [superView addSubview:self.loginView];
    WeakObject(superView, wSuperView)
    if([superView isKindOfClass:[UIScrollView class]])
    {
        [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSuperView.mas_left).with.offset(offset.left);
            make.right.equalTo(wSuperView.mas_right).with.offset(-offset.right);
            make.top.equalTo(wSuperView.mas_top).with.offset(offset.top);
            make.bottom.equalTo(wSuperView.mas_bottom).with.offset(-offset.bottom);
            make.width.equalTo(wSuperView.mas_width).with.offset(-offset.left-offset.right);
            make.height.equalTo(wSuperView.mas_height).with.offset(-offset.top-offset.bottom);
        }];
    }else
    {
        [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wSuperView).insets(offset);
        }];
    }
    self.loginHandler=reloadBlock;
    [superView bringSubviewToFront:self.loginView];
    [self.loginView setHidden:NO];
}

#pragma mark ---loadingDataView----
-(void)addLoadingDataViewWithTitle:(NSString *)title
{
    self.loadDataView=[[SYLoadingDataView alloc]initWithFrame:CGRectZero];
    [self.loadDataView.showLabel setText:title];
}
-(void)showloadingDataView
{
    [self ShowloadingDataViewFromSuperView:self.view];
}
-(void)hideLoadingDataView
{
    if(self.maskView)
        [self.maskView removeFromSuperview];
    [self.loadDataView.superview sendSubviewToBack:self.loadDataView];
    [self.loadDataView removeFromSuperview];
    [self.loadDataView setHidden:YES];
}
-(void)ShowloadingDataViewFromSuperView:(UIView *)asuperView
{
    [self ShowloadingDataViewFromSuperView:asuperView AndEdageOffSet:UIEdgeInsetsZero];
    
}
-(void)ShowloadingDataViewFromSuperView:(UIView *)asuperView
                         AndEdageOffSet:(UIEdgeInsets)offset
{
    UIView *superView=asuperView;
    if([asuperView isKindOfClass:[UITableView class]])
    {
        if(!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            if(self.maskView==nil)
            {
                self.maskView=[[SYControl alloc]initWithFrame:CGRectMake(0,0, superView.frame.size.width, superView.frame.size.height)];
                [self.maskView setBackgroundColor:[UIColor clearColor]];
                [self.maskView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            }
            [superView addSubview:self.maskView];
            superView=self.maskView;
        }
    }
    [superView addSubview:self.loadDataView];
    WeakObject(superView, wSuperView)
    if([superView isKindOfClass:[UIScrollView class]])
    {
        [self.loadDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSuperView.mas_left).with.offset(offset.left);
            make.right.equalTo(wSuperView.mas_right).with.offset(-offset.right);
            make.top.equalTo(wSuperView.mas_top).with.offset(offset.top);
            make.bottom.equalTo(wSuperView.mas_bottom).with.offset(-offset.bottom);
            make.width.equalTo(wSuperView.mas_width).with.offset(-offset.left-offset.right);
            make.height.equalTo(wSuperView.mas_height).with.offset(-offset.top-offset.bottom);
        }];
    }else
    {
        [self.loadDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wSuperView).insets(offset);
        }];
    }
    [superView bringSubviewToFront:self.loadDataView];
    [self.loadDataView setHidden:NO];
}

-(void)setviewControllerForTabItemSelectImage:(NSString *)selectImage
                             AndUnselectImage:(NSString *)unselect
                                 AndTitleName:(NSString *)title
{
    UIImage *selecedImage=[[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *unselectImage=[[UIImage imageNamed:unselect] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem =[[UITabBarItem alloc]initWithTitle:title image:unselectImage selectedImage:selecedImage];
    if (!title) {
        self.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);
    }
}
#pragma mark ---IBAction----
-(IBAction)reloadData:(id)sender
{
    self.handler(self.networkErrorView.operationButton);
}
-(IBAction)loginAction:(id)sender
{
    self.loginHandler(self.loginView.operationButton);
}
@end
