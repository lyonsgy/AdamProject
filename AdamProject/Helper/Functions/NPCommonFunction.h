//
//  SYCommonFunction.h
//  SyouInfomationPublish
//
//  Created by nplus on 14-4-23.
//  Copyright (c) 2014年 Syousoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#define M_FIX_NULL_STRING(_value,_default)  ([_value isEqual:[NSNull null]]||_value==nil)?_default:_value//判断对象是否为空
#define M_FIX_NULL(_value)  ([_value isEqual:[NSNull null]]||_value==nil)//判断对象是否为空
#define PX_TRANS(_value) _value/1.44f //1080尺寸切换750尺寸
#define PT_TRANS(_value) _value*100/144 //1080尺寸字体大小切换750尺寸
#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define ABVOEIOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 //判断设备版本
#define ABVOEIOS11 [[[UIDevice currentDevice]systemVersion] floatValue] < 11.0 //判断设备版本小于
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)//
#define DOCUMENT   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define CACHELIBRARY [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define WeakObject(object,weakObject)  __weak __typeof(&*object)weakObject = object;
#define MAINSCREEN  [UIScreen mainScreen].bounds
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ADD_DYNAMIC_PROPERTY(PROPERTY_TYPE,PROPERTY_NAME,SETTER_NAME) \
@dynamic PROPERTY_NAME ; \
static char kProperty##PROPERTY_NAME; \
- ( PROPERTY_TYPE ) PROPERTY_NAME \
{ \
    return ( PROPERTY_TYPE ) objc_getAssociatedObject(self, &(kProperty##PROPERTY_NAME ) ); \
} \
\
- (void) SETTER_NAME :( PROPERTY_TYPE ) PROPERTY_NAME \
{ \
    objc_setAssociatedObject(self, &kProperty##PROPERTY_NAME , PROPERTY_NAME , OBJC_ASSOCIATION_RETAIN); \
} \

#define ADD_DYNAMIC_PROPERTY_COPY(PROPERTY_TYPE,PROPERTY_NAME,SETTER_NAME) \
@dynamic PROPERTY_NAME ; \
static char kProperty##PROPERTY_NAME; \
- ( PROPERTY_TYPE ) PROPERTY_NAME \
{ \
return ( PROPERTY_TYPE ) objc_getAssociatedObject(self, &(kProperty##PROPERTY_NAME ) ); \
} \
\
- (void) SETTER_NAME :( PROPERTY_TYPE ) PROPERTY_NAME \
{ \
objc_setAssociatedObject(self, &kProperty##PROPERTY_NAME , PROPERTY_NAME , OBJC_ASSOCIATION_COPY_NONATOMIC); \
} \



@interface NPCommonFunction : NSObject
+(BOOL)positionAllowed;
+(NSComparisonResult)compareAppVersion:(NSString *)appVersion;
+(NSString *)appVersion;
+(BOOL)isAllowedNotification;
+(NSString *)appName;
+(NSString *)convertDistanceWithMete:(int)mete;
+(BOOL)getMediaIsAvailableFromSource:(UIImagePickerControllerSourceType)sourceType;
+(BOOL)getMediaIsPermissionFromSource:(UIImagePickerControllerSourceType)sourceType;
+(BOOL)getAudioIsPermission;
+(BOOL)getAudioIsAvailable;
+(BOOL)isSecurityCode:(NSString *)securityCodeStr;
+(BOOL)isPhoneNumber:(NSString *)phoneStr;
+(BOOL)passWordIsAvailable:(NSString *)passWord;
+(BOOL)passWordisavailable:(NSString *)password;
+(BOOL)accountDisavailable:(NSString *)account;
+(BOOL)mailAddressAvailable:(NSString *)mailAddress;
+(UIViewController *)getCurrentViewController;
+(NSString *)RC4text:(NSString *)text;
+(NSString *)removeRetureKeyWithString:(NSString *)string;
+(BOOL)isAllSpaceOfString:(NSString *)string;
+(BOOL)isCoachCarAppeared;
+(NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat;
+(NSString *)stringFromDate:(NSDate *)date;
+(NSDate *)dateFromString:(NSString *)dateString;
+(NSDate *)dataFromTimeString:(NSString *)dateString withDateFormat:(NSString *)dateFormate;
+(NSString*)timeStringFromStting:(NSString *)dateString withDateFormat:(NSString *)dateFormate outDateFormate:(NSString *)outDateFormate;

+(NSString *)numberStringFromString:(NSString *)string;
+(NSString *)numberStringFromIntNumber:(NSInteger)number;
//判断是否是邮箱
+(BOOL)isValidateEmail:(NSString *)email;
//判断是否纯数字
+(BOOL)isPureInt:(NSString*)string;

//秒数转时间
+(NSString *)currentTimeStringWithCurrentTime:(NSInteger)currentTime;
+(NSInteger )timeWithTimeString:(NSString*)timeString;

+(UIImage*)convertViewToImage:(UIView*)v;

+(BOOL)cornerRadiusWithView:(UIView*)view withCornerRadius:(CGFloat)cornerRadius;
+(BOOL)cornerRadiusWithButton:(UIButton*)button withCornerRadius:(CGFloat)cornerRadius;

+(NSArray *)beforeMonth;

+(NSString *)stringWithDateString:(NSString *)string;
+(NSMutableAttributedString *)attributedStringWithDateString:(NSString *)string;

+ (NSString *)fileSizeWithInterge:(NSInteger)size;
+ (NSData *)toJSONData:(id)theData;

+ (NSString *)todayYearMonthDay;
+ (NSString *)getTimeStamp;
+ (NSString *)getVideoSaveFilePathString;
+ (NSString *)getDocumentDirectory;

+ (NSMutableArray *)sortedArrayWithArray:(NSMutableArray *)array;
+ (BOOL)isWifiNetWork;

+(void)startButtonAnimate:(UIButton *)button;
+(void)stopButtonAnimate:(UIButton*)button;

+(NSInteger)columnWithInteger:(NSInteger)number;

//去appStore评论
+(void)gotoAppstoreComment;
+(NSString*)fullString:(NSString*)string withMaxIndex:(NSInteger)max;
+(UIVisualEffectView *)addBlurEffectViewOnView:(UIView*)view frame:(CGRect)frame effectWithStyle:(UIBlurEffectStyle)style;
+ (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view;
+ (NSString *)currentTimeStr;
+ (NSString *)getDateStringWithTime:(NSInteger)time dateFormat:(NSString*)dateFormat;
+ (NSInteger)getTimeStrWithString:(NSString *)str;
@end
