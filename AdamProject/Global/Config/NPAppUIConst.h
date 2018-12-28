//
//  NPAppUIConst.h
//  Jikebaba
//
//  Created by nplus on 15/4/13.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import <Foundation/Foundation.h>
//color

static NSInteger  const NPPalePeach       =0xfee4a2;
static NSInteger  const NPPalePeachTwo    =0xfeecbd;

static NSInteger  const NPGoldenRod       =0xfabc05;
static NSInteger  const NPPaleGold        =0xfcd674;
static NSInteger  const NPGreyish         =0x434343;

static NSInteger  const NPWhiteTwo        =0xd8d8d8;
static NSInteger  const NPWhiteThree      =0xefefef;
static NSInteger  const NPWhiteFour       =0xe9e9e9;
static NSInteger  const NPWhiteFive       =0xf9f9f9;
static NSInteger  const NPWhiteSix        =0xe5e5e5;
static NSInteger  const NPWhiteSeven      =0xf4f4f4;

static NSInteger  const NPWarmGreyTwo   =0x979797;
static NSInteger  const NPWarmGreyThree   =0x8c8c8c;
static NSInteger  const NPGreyishBrownTwo =0x000000;
static NSInteger  const NPLightblueTwo    =0x6bcef5;
static NSInteger  const NPDarkSkyBlue     =0x32bbf1;
static NSInteger  const NPSalmon          =0xff7a7a;

static NSInteger  const NPBackgroundColor =0xffffff;
static NSInteger  const NPNavigationColor =0x000000;

static NSString * const AlertTitle = @"友情提醒";
static NSString * const AlertYes = @"确定";
static NSString * const AlertNO = @"取消";
static double  const  AlertDismissTime = 1.5;

//common
static NSString * const NetWorkError = @"加载失败";

//StudyOnline
static NSString * const MovieForbidenUNWiFi = @"\n当前为非WIFI网络播放\n是否继续播放？";
static NSString * const MovieInUNWiFi = @"正在使用2G/3G/4G网络";
static NSString * const MovieForNetWorkError =@"网络连接失败，请重新检查网络";

//硬件权限
static NSString * const NO_MiCRO_PERMISSION=@"“童yan”没有访问麦克风的权限";
static NSString * const NO_CAMERA_PERMISSION=@"“童yan”没有访问相机的权限";
static NSString * const TAKE_MICRO_PERMISSION_ALERT_MESSAGE=@"请您在“设置->隐私->麦克风”中开启“童yan”访问麦克风的权限";
static NSString * const TAKE_CAMERA_PERMISSION_ALERT_MESSAGE=@"请您在“设置->隐私->相机”中开启“童yan”访问相机的权限";
static NSString * const CAMERA_CAN_NOT_USE=@"设备不支持照相功能";

static NSString * const NO_PHOTOLIBRARY_PERMISSION=@"“童yan”没有访问照片的权限";
static NSString * const TAKE_PHOTOLIBRARY_PERMISSION_ALERT_MESSAGE=@"请您在“设置->隐私->照片”中开启“童yan”访问照片的权限";
static NSString * const PHOTOLIBRARY_CAN_NOT_USE=@"设备不支持查看照片功能";


//home
static NSString * const SubmitLoading = @"正在提交...";
static NSString * const SubmitSuccess = @"提交成功";
static NSString * const SubmitFail = @"提交失败";

//pay
static NSString * const orderError = @"支付异常 ";
static NSString * const orderCancel = @"支付取消 ";
static NSString * const orderSuccess = @"支付成功 ";
static NSString * const payFail = @"支付失败";
static NSString * const payFinish = @"已支付";

static NSString * const SYDeviceLogError = @"您的账号已在其他设备登录,请重新登录";

@interface NPAppUIConst : NSObject

@end
