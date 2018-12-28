//
//  UIViewController+AddSubView.h
//  Jikebaba
//
//  Created by nplus on 15/4/27.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYNoDataShowView.h"
#import "SYNetworkErrorView.h"
#import "SYLoadingDataView.h"
#import "SYControl.h"

typedef void(^buttonHandler)(UIButton *sender);
typedef void(^loginhandle)(UIButton *sender);
@interface UIViewController (AddSubView)

@property (nonatomic,strong)SYNoDataShowView *nodataView;
@property (nonatomic,strong)SYNoDataShowView *nodataView1;
@property (nonatomic,strong)SYNoDataShowView *nodataView2;
@property (nonatomic,strong)SYNetworkErrorView*networkErrorView;
@property (nonatomic,strong)SYNetworkErrorView*networkErrorView1;
@property (nonatomic,strong)SYNetworkErrorView*networkErrorView2;
@property (nonatomic,strong)SYLoadingDataView *loadDataView;
@property (nonatomic,strong)SYNetworkErrorView*loginView;
@property (nonatomic,strong)SYControl *maskView;
@property (nonatomic,copy) buttonHandler handler;
@property (nonatomic,copy) loginhandle loginHandler;
-(void)addNOdataViewWithImage:(UIImage *)image AndTitle:(NSString *)title AndSubTitle:(NSString *)subTitle;
-(void)showNodataView;
-(void)hideNodateView;
-(void)ShowNOdataViewFromSuperView:(UIView *)superView;

-(void)ShowWillNetWorkErrorViewFromSuperView:(UIView *)asuperView
                             AndEdageOffSet:(UIEdgeInsets)offset
                            WithReloadBlock:(void(^)(UIButton *sender))reloadBlock;

-(void)ShowHasNetWorkErrorViewFromSuperView:(UIView *)asuperView
                             AndEdageOffSet:(UIEdgeInsets)offset
                            WithReloadBlock:(void(^)(UIButton *sender))reloadBlock;
/**
 will无数据显示层

 @param asuperView 显示所在父view
 @param NOdataTitle 无数据提示
 @param NOdataImage 无数据图片
 @param offset 偏移值
 */
-(void)ShowWillNOdataViewFromSuperView:(UIView *)asuperView
                       NOdataTitle:(NSString *)NOdataTitle
                       NOdataImage:(UIImage *)NOdataImage
                    AndEdageOffSet:(UIEdgeInsets)offset;
/**
 has无数据显示层
 
 @param asuperView 显示所在父view
 @param NOdataTitle 无数据提示
 @param NOdataImage 无数据图片
 @param offset 偏移值
 */
-(void)ShowHasNOdataViewFromSuperView:(UIView *)asuperView
                           NOdataTitle:(NSString *)NOdataTitle
                           NOdataImage:(UIImage *)NOdataImage
                        AndEdageOffSet:(UIEdgeInsets)offset;
/**
 无数据显示层
 
 @param asuperView 显示所在父view
 @param NOdataTitle 无数据提示
 @param NOdataImage 无数据图片
 @param offset 偏移值
 */
-(void)ShowNOdataViewFromSuperView:(UIView *)asuperView
                       NOdataTitle:(NSString *)NOdataTitle
                       NOdataImage:(UIImage *)NOdataImage
                    AndEdageOffSet:(UIEdgeInsets)offset;

-(void)ShowNOdataViewFromSuperView:(UIView *)superView
                    AndEdageOffSet:(UIEdgeInsets)offset;


-(void)addNetWorkErrorViewWithImage:(UIImage *)image Title:(NSString *)title;
-(void)showNetWorkErrorViewWithReloadBlock:(void(^)(UIButton *sender))reloadBlock;
-(void)hideNetWorkErrorView;
-(void)ShowNetWorkErrorViewFromSuperView:(UIView *)superView WithReloadBlock:(void(^)(UIButton *sender))reloadBlock;
-(void)ShowNetWorkErrorViewFromSuperView:(UIView *)superView
                          AndEdageOffSet:(UIEdgeInsets)offset
                         WithReloadBlock:(void(^)(UIButton *sender))reloadBlock;


-(void)addloginViewWithTitle:(NSString *)title;
-(void)showloginViewWithReloadBlock:(void(^)(UIButton *sender))reloadBlock;
-(void)hideloginView;
-(void)ShowloginViewFromSuperView:(UIView *)superView WithReloadBlock:(void(^)(UIButton *sender))reloadBlock;
-(void)ShowloginViewFromSuperView:(UIView *)superView
                          AndEdageOffSet:(UIEdgeInsets)offset
                         WithReloadBlock:(void(^)(UIButton *sender))reloadBlock;


-(void)addLoadingDataViewWithTitle:(NSString *)title;
-(void)showloadingDataView;
-(void)hideLoadingDataView;
-(void)ShowloadingDataViewFromSuperView:(UIView *)superView
                         AndEdageOffSet:(UIEdgeInsets)offset;

-(void)hideAllAlertView;
-(void)hideWillAlertView;
-(void)hideHasAlertView;
-(void)setviewControllerForTabItemSelectImage:(NSString *)selectImage
                             AndUnselectImage:(NSString *)unselect
                                 AndTitleName:(NSString *)title;
@end
