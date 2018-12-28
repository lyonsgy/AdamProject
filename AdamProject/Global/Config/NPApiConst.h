//
//  NPApiConst.h
//  Jikebaba
//
//  Created by nplus on 15/4/8.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define kSYWEB_API_URL @"http://api.jikebaba.com/api/" //S1
#define kNPARTICLE_URL @"http://article.jikebaba.com/api/articles/id.html" //文章详情
#define kSYIMG_API_URL @"http://p10ikylm2.bkt.clouddn.com/" //七牛Url,TODO:https
#define kNPARTICLE_DETAIL_URL(_value)  [kNPARTICLE_URL stringByReplacingOccurrencesOfString:@"id" withString:_value]//文章详情地址
#define kNPIMG(_value)  [NSString stringWithFormat:@"%@%@",kSYIMG_API_URL,_value] //图片地址
#define kNPERROR_API_URL @"https://log.tongyanhq.com" //error上传
#define kPROCOTOL_URL @""//用户协议

#define kNPSLOGAN @"Slogan" //Slogan
#define kNPAPPSTOREADDRESS @"www.tongyanhq.com" //AppStoreAddress
#define AppID @"1151334693" //上线前检查AppID

#ifdef DEBUG
#define ISDEBUG 1
#else
#define ISDEBUG 0
#endif

#define TabbarItemNums 4.0    //tabbar的数量

//测试model数据
#define TESTMODEDTATA @"test_mode_Data"

#define STATIC_REQUEST(name,request) static NSString * const NPRequest##name##URL = request;

#define NOTIFICATION(Name) static NSString * const NP##Name##Notification =@#Name;

static NSInteger  const getTimeOut = 10;
static NSInteger  const GetAuthCodeTimeOut = 30;
static NSInteger  const LoginTimeOut = 10;
static NSInteger  const PostTimeOut = 10;
static NSInteger  const PostFileTimeOut = 60;
static NSInteger  const BaseDataTimeOut =10;

static NSString *const NPArticleTagNotification = @"NPArticleTagNotification";
static NSString *const NPArticleColumnNotification = @"NPArticleColumnNotification";

/**
 *  图像压缩
 */
#define headSize  CGSizeMake(200, 200)
#define headBackSize CGSizeMake(640,350)
#define UploadSizeWidth 960
#define capriccioImageSize CGSizeMake(640, 640)

#define LastRemoveVersion @"1.0.0"
#define LastVersion @"lastVersion"
/**
 *接口请求
 *
 */
//登录
STATIC_REQUEST(UserInfo, @"self")//用户信息
STATIC_REQUEST(VerificationCode, @"verificationCode")//获取验证码·
STATIC_REQUEST(Login, @"login")//登录·
STATIC_REQUEST(WechatLogin, @"wechat/login")//微信登录
STATIC_REQUEST(WechatBind, @"wechat/bind")//绑定微信/解绑微信
STATIC_REQUEST(WechatRegister, @"wechat/register")//微信注册
STATIC_REQUEST(Business, @"business")//申请认证

//七牛
STATIC_REQUEST(QiniuToken, @"qiniu/token")//七牛token·

//文章相关
STATIC_REQUEST(IndexTopArticles, @"index/topArticles")//推荐文章（包含Banner)·
STATIC_REQUEST(FavouritesArticles, @"self/favourites/articles")//收藏的文章&收藏文章·
STATIC_REQUEST(Articles, @"articles")//根据标签获取文章·
STATIC_REQUEST(SearchHistories, @"searchHistories")//热门搜索·

//频道
STATIC_REQUEST(Channels, @"channels")//频道·
STATIC_REQUEST(FavouritesChannels, @"self/favourites/channels")//关注的频道&关注频道·

//公司，企业相关
STATIC_REQUEST(FavouritesCompanies, @"self/favourites/companies")//关注公司&关注的公司列表
STATIC_REQUEST(Companies, @"companies")//公司列表
STATIC_REQUEST(TopCompanies, @"topCompanies")//热门公司列表

//作者相关
STATIC_REQUEST(FavouritesAuthors, @"self/favourites/authors")//收藏作者&收藏的作者列表

//领域相关
STATIC_REQUEST(Domains, @"domains")//领域列表·
STATIC_REQUEST(TopDomains, @"topDomains")//热门领域列表·
STATIC_REQUEST(FavouritesDomains, @"self/favourites/domains")//收藏領域&收藏的领域列表·
STATIC_REQUEST(IndexTopDomains, @"index/topDomains")//热门领域列表(包含banner)·

//栏目
STATIC_REQUEST(Columns, @"columns")//栏目列表
STATIC_REQUEST(FavouritesColumns, @"self/favourites/columns")//我收藏的栏目列表&收藏栏目

//动态
STATIC_REQUEST(SelfDynamics, @"self/dynamics")//动态消息·
STATIC_REQUEST(Dynamics, @"dynamics")//关注的动态·
STATIC_REQUEST(FavouritesTags, @"self/favourites/tags")//收藏的标签

//活动
STATIC_REQUEST(Meetings, @"meetings")//活动日历

//交换名片
STATIC_REQUEST(Relations, @"self/relations")//最近联系&交换名片&同意交换名片&拒绝交换名片

NOTIFICATION(PayOrder)
NOTIFICATION(PayResult)
NOTIFICATION(HasNewMessage)
NOTIFICATION(LogOut)
NOTIFICATION(ReceiveMessage)
NOTIFICATION(UserInfoChange)


#define DEVICE_TOKEN @"DEVICE_TOKEN"

#define PhoneType @"ios"
#define SYAliPay @"alipay"
#define SYWXPay @"wx"
#define SYPageSize @10

#define SYTimeDetailFormatter @"yyyy-MM-dd HH:mm:ss"
#define SYDateDetailFormatter @"yyyy-MM-dd"
#define SYTimeFormatter @"HH:mm:ss"

//HX system sender
#define SYSystem_pay @"system_payment"
#define SYSystem_refund @"system_refund"
#define SYSystem @"system"

#define MessageOrderType @"order"

//1 使用2G/3G/4G   0 不使用2G/3G/4G
#define ISWIFI @"isWIFI"

typedef NS_ENUM(NSUInteger, SYHTTPCode) {
    SYHTTPCodeSuccess=200,
    SYHTTPCodeSuccessCreate=201,
    SYHTTPCodeSuccessNodata=204
};

typedef NS_ENUM(NSUInteger, SYErrorType) {
    SYErrorTypeBaseParamError=0,
    SYErrorTypeJsonParameError,
    SYErrorTypeUserInvalidError,
    SYErrorTypeVerifyCodeError,
    SYErrorTypeVerifyCodeOverDueError,
    SYErrorTypeFileUploadError,
    SYErrorTypeDatabaseError,
    SYErrorTypePlatformVerifyCodeError,
    SYErrorTypeActivityOrderStatusError,
    SYErrorTypeActivityStatusError,
};

typedef NS_ENUM(NSUInteger, SYSytemMessageType) {
    SYSytemMessageTypeAPNS=0,
    SYSytemMessageTypePay,
    SYSytemMessageTypeRefund,
    SYSytemMessageTypeCoacherApplySucess,
    SYSytemMessageTypeCoacherApplyFail
};

//typedef NS_ENUM(NSInteger, SYPerson) {
//    SYPersonMale=0,
//    SYPersonFeMale,
//};

typedef NS_ENUM(NSUInteger, SYPayChannelType) {
    SYPayChannelTypeZFB=0,
    SYPayChannelTypeWX,
};

@interface NPApiConst : NSObject

@end

