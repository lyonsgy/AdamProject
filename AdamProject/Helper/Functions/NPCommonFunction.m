//
//  SYCommonFunction.m
//  SyouInfomationPublish
//
//  Created by nplus on 14-4-23.
//  Copyright (c) 2014年 Syousoft. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworkReachabilityManager.h"
#import "RC4.h"
#define ADVANCE_IOS8 [[[UIDevice currentDevice]systemVersion]floatValue]>=8.0
#define VIDEO_FOLDER @"videoFolder"
static NSString *templateReviewURL = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APP_ID";
static NSString *templateReviewURLiOS7 = @"itms-apps://itunes.apple.com/app/idAPP_ID";
static NSString *templateReviewURLiOS8 = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=APP_ID&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software";

@implementation NPCommonFunction
+(BOOL)positionAllowed
{
    CLAuthorizationStatus status= [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            return YES;
        }
            break;
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            return NO;
        }
        default:
            return YES;
            break;
    }
    
    
}
+(BOOL)isPhoneNumber:(NSString *)phoneStr
{
    NSString * regex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [pred evaluateWithObject:phoneStr];
}
+(BOOL)isSecurityCode:(NSString *)securityCodeStr
{
    NSString * regex = @"[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [pred evaluateWithObject:securityCodeStr];
}
+(BOOL)passWordIsAvailable:(NSString *)passWord
{
    NSString * regex = @"^[A-Za-z0-9]{6,15}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [pred evaluateWithObject:passWord];
}
+(BOOL)accountDisavailable:(NSString *)account
{
    if (account.length >= 6) {
        return YES;
    }
    return NO;
}
+(BOOL)passWordisavailable:(NSString *)password
{
    if (password.length >= 6 && password.length <= 15) {
        return YES;
    }
    return NO;
}
/**
 *  邮箱验证
 *
 *  @param mailAddress 邮箱地址
 *
 *  @return 返回值YES:邮箱地址合法 NO：邮箱地址不合法
 */
+(BOOL)mailAddressAvailable:(NSString *)mailAddress
{
    NSString * regex = @"^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [pred evaluateWithObject:mailAddress];
}
+(NSComparisonResult)compareAppVersion:(NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [app_build compare:appVersion];
}
+(NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_build;
}
+ (BOOL)isAllowedNotification {
    //iOS8 check if user allow notification
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != setting.types) {
        return YES;
    }
    return NO;
}
+(NSString *)appName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_build;
}
+(BOOL)getMediaIsPermissionFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if (sourceType==UIImagePickerControllerSourceTypeCamera)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusDenied)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == AVAuthorizationStatusDenied)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
}
+(BOOL)getMediaIsAvailableFromSource:(UIImagePickerControllerSourceType)sourceType
{
    BOOL isAvailable=[UIImagePickerController isSourceTypeAvailable:sourceType];
    return isAvailable;
}
+(BOOL)getAudioIsAvailable
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if(session.isInputAvailable)
    {
        return YES;
    }
    else
        return NO;
}
+(BOOL)getAudioIsPermission
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusDenied)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
+(NSString *)convertDistanceWithMete:(int)mete
{
    
    NSString *distanceStr;
    if(mete/1000<=0)
    {
        distanceStr =[NSString stringWithFormat:@"%dm",mete];
    }
    else
    {
        distanceStr =[NSString stringWithFormat:@"%.1fkm",mete*1.0/1000];
    }
    return distanceStr;
}


+(UIViewController *)getCurrentViewController
{
    
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    
    UIViewController *appRootVC = topWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
    
    /*
     UIViewController *viewcontroller;
     UIView *rootView = [[topWindow subviews] objectAtIndex:0];
     id nextResponder = [rootView nextResponder];
     
     if (nextResponder&&[nextResponder isKindOfClass:[UIViewController class]])
     viewcontroller = nextResponder;
     else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
     viewcontroller = topWindow.rootViewController;
     else
     NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
     
     return viewcontroller;
     */
    
}
#define key @"syousoft"
+(NSString *)RC4text:(NSString *)text
{
    NSString *ciphertext;
    RC4 *rc=[[RC4 alloc]initWithKey:key];
    ciphertext=[rc encryptString:text];
    return ciphertext;
}
+(NSString *)removeRetureKeyWithString:(NSString *)string
{
    NSString *regTags = @"[.\n]+";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionUseUnixLineSeparators error:&error];
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    NSString *str=string;
    BOOL isFirst=YES;
    NSMutableArray *rangeArr=[NSMutableArray array];
    for (NSTextCheckingResult *match in matches)
    {
        BOOL isSame=NO;
        NSRange matchRange = [match range];
        NSString *tagString = [string substringWithRange:matchRange];
        if (isFirst)
        {
            [rangeArr addObject:tagString];
            isFirst=NO;
        }
        for (NSString *len in rangeArr)
        {
            if ([tagString isEqualToString:len])
            {
                isSame=YES;
            }
        }
        if (!isSame)
        {
            [rangeArr addObject:tagString];
        }
    }
    for (int i=0; i<rangeArr.count; i++)
    {
        NSString *temp=rangeArr[i];
        for (int j=i+1; j<rangeArr.count; j++)
        {
            NSString *tempStr=rangeArr[j];
            if (temp.length<tempStr.length)
            {
                NSString *tempFuck=rangeArr[i];
                rangeArr[i]=tempStr;
                rangeArr[j]=tempFuck;
            }
        }
    }
    for (int i=0; i<rangeArr.count; i++)
    {
        NSString *temp=rangeArr[i];
        str=[str stringByReplacingOccurrencesOfString:temp withString:@" "];
    }
    return str;
}
+(BOOL)isAllSpaceOfString:(NSString *)string
{
    NSInteger strLength=string.length;
    NSInteger spaceNum=0;
    for (NSInteger i=0;i<strLength;i++)
    {
        unichar a=[string characterAtIndex:i];
        if (a==' ')
        {
            spaceNum=spaceNum+1;
        }
    }
    if (spaceNum==strLength)
    {
        return YES;
    }
    return NO;
}
+(BOOL)isCoachCarAppeared
{
    NSDate * nowDate=[NSDate date];
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * nowDateString=[dateFormatter stringFromDate:nowDate];
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * nowDateStr=[NSString stringWithFormat:@"SYCoachCard%@",nowDateString];
    NSNumber * stateNumber=[userDefaults objectForKey:nowDateStr];
    if (!stateNumber)
    {
        return NO;
    }
    return YES;
}
+(NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat
{
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:dateFormat];
    
    NSString * dateString=[dateFormatter stringFromDate:date];
    return dateString;
}
+(NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString * dateString=[dateFormatter stringFromDate:date];
    return dateString;
}
+(NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-M-d HH:mm:s"];
    NSDate * date=[dateFormatter dateFromString:dateString];
    return date;
}
+(NSDate *)dataFromTimeString:(NSString *)dateString withDateFormat:(NSString *)dateFormate{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:dateFormate];
    NSDate * date=[dateFormatter dateFromString:dateString];
    return date;
}

+ (NSString*)timeStringFromStting:(NSString *)dateString withDateFormat:(NSString *)dateFormate outDateFormate:(NSString *)outDateFormate
{
    
    NSDate *timeDate = [self dataFromTimeString:dateString withDateFormat:dateFormate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:outDateFormate];
    
    //用[NSDate date]可以获取系统当前时间
    
    NSString *currentDateStr = [dateFormatter stringFromDate:timeDate];
    
    return currentDateStr;
}
+(NSString *)numberStringFromString:(NSString *)string{
    NSString *numberString = string;
    if (numberString.length>4) {
        if ([[numberString substringFromIndex:(numberString.length-3)]  intValue]>500) {
            numberString = [NSString stringWithFormat:@"%d",[[numberString substringToIndex:(numberString.length-3)]  intValue]+1];
        }else{
            numberString = [numberString substringToIndex:(numberString.length-3)];
        }
        numberString = [NSString stringWithFormat:@"%@.%@万",[numberString substringToIndex:(numberString.length-1)],[numberString substringFromIndex:(numberString.length-1)]];
    }
    return numberString;
}
+(NSString *)numberStringFromIntNumber:(NSInteger)number
{
    if(number>10000)
    {
        return [NSString stringWithFormat:@"%.1f万",number*1.0/10000];
    }else
    {
        return [NSString stringWithFormat:@"%ld",(long)number];
    }
}

//邮箱判断
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//秒数转时间
+(NSString *)currentTimeStringWithCurrentTime:(NSInteger)currentTime{
    
    // 当前时长进度progress
    NSInteger proMin = currentTime / 60;//当前秒
    NSInteger proSec = currentTime % 60;//当前分钟
    return [NSString stringWithFormat:@"%02zd:%02zd", proMin, proSec];
}

//时间转秒数
+(NSInteger )timeWithTimeString:(NSString*)timeString{
    // 当前时长进度progress
    NSInteger min =  [[timeString componentsSeparatedByString:@":"][0] integerValue]; // 01
    NSInteger second = [[timeString componentsSeparatedByString:@":"][1] integerValue]; // 43
    return second+min*60;
}

/**
 UIView对象转UIImage对象
 
 @param v UIView
 @return UIImage
 */
+(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(BOOL)cornerRadiusWithView:(UIView*)view withCornerRadius:(CGFloat)cornerRadius{
    view.layer.cornerRadius = cornerRadius;
    return YES;
}
+(BOOL)cornerRadiusWithButton:(UIButton*)button withCornerRadius:(CGFloat)cornerRadius{
    button.layer.cornerRadius = cornerRadius;
    return YES;
}


/**
 当前月份前6个月（包括当前月）
 
 @return 当前月份前6个月（包括当前月）的数组
 */
+(NSArray *)beforeMonth{
    NSDate *now = [NSDate date];
    NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    
    NSInteger beforeYear = year;
    NSInteger beforeMonth = month;
    
    NSLog(@"year is: %ld", (long)year);
    NSLog(@"month is: %ld", (long)month);
    
    NSMutableArray *dateArray = [NSMutableArray new];
    [dateArray addObject:[NSString stringWithFormat:@"%ld年%ld月",(long)beforeYear,(long)beforeMonth]];
    
    for (int i = 0; i < 5; i++) {
        beforeMonth = beforeMonth-1;
        if (beforeMonth < 1) {
            beforeMonth = 12;
            beforeYear = year-1;
        }
        [dateArray addObject:[NSString stringWithFormat:@"%ld年%ld月",(long)beforeYear,(long)beforeMonth]];
    }
    return dateArray;
}

/**
 获取当前年月日
 
 @return 年月日YYYYMMDD
 */
+(NSString *)todayYearMonthDay{
    NSDate *now = [NSDate date];
    NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    
    NSString *monthStr = [NSString new];
    if (month<10) {
        monthStr = [NSString stringWithFormat:@"0%ld",(long)month];
    }else{
        monthStr = [NSString stringWithFormat:@"%ld",(long)month];
    }
    NSString *dayStr = [NSString new];
    if (day<10) {
        dayStr = [NSString stringWithFormat:@"0%ld",(long)day];
    }else{
        dayStr = [NSString stringWithFormat:@"%ld",(long)day];
    }
    NSString *today = [NSString stringWithFormat:@"%ld%@%@",(long)year,monthStr,dayStr];
    return today;
}

/**
 "年月"转"-"
 
 @param string yyyy年m月
 @return yyyy-m
 */
+(NSString *)stringWithDateString:(NSString *)string{
    
    NSString *dateStr = [string stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"月" withString:@""];
    NSString *newStr = [dateStr substringFromIndex:5];
    NSString *dateString = [dateStr substringToIndex:5];
    if (newStr.length<=1) {
        dateString = [NSString stringWithFormat:@"%@0%@",dateString,newStr];
        return dateString;
    }
    return dateStr;
}


/**
 "yyyy年m月"中的"年月"字体大小
 
 @param string yyyy年m月
 @return 修改完字体大小的"yyyy年m月"attributedString
 */
+(NSMutableAttributedString *)attributedStringWithDateString:(NSString *)string{
    //创建NSMutableAttributedString
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:string];
    
    //设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:NSMakeRange(0, 4)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(4, 1)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:NSMakeRange(5, 2)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(string.length-1, 1)];
    return attrStr;
}


/**
 计算文件大小
 
 @param size 字节大小
 @return 带单位的大小
 */
+ (NSString *)fileSizeWithInterge:(NSInteger)size {
    
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {
        // 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
        
    }else if (size < 1024 * 1024){
        // 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
        
    }else if (size < 1024 * 1024 * 1024){
        
        // 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
        
    }else{
        
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}


/**
 转成jsonData
 
 @param theData array数组或dic字典
 @return jsonData
 */
+ (NSData *)toJSONData:(id)theData{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

/**
 时间戳（13位）
 
 @return 时间戳string
 */
+ (NSString *)getTimeStamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    return timeString;
}

/**
 录制视频地址
 
 @return 录制视频 (.mov)
 */
+ (NSString *)getVideoSaveFilePathString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    path = [path stringByAppendingPathComponent:VIDEO_FOLDER];
    
    NSString *fileName = [path stringByAppendingPathComponent:@"merge.mov"];
    
    return fileName;
}

//
/**
 get local file dir which is readwrite able
 
 @return 本地Document文件夹路径
 */
+ (NSString *)getDocumentDirectory {
    NSString * path = NSHomeDirectory();
    NSLog(@"NSHomeDirectory:%@",path);
    NSString * userName = NSUserName();
    NSString * rootPath = NSHomeDirectoryForUser(userName);
    NSLog(@"NSHomeDirectoryForUser:%@",rootPath);
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

/**
 数组排序
 
 @param array 普通数组
 @return 排序后数组
 */
+ (NSMutableArray *)sortedArrayWithArray:(NSMutableArray *)array{
    NSSet *set = [NSSet setWithArray:array];
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
    NSArray *sortSetArray = [set sortedArrayUsingDescriptors:sortDesc];
    return [NSMutableArray arrayWithArray:sortSetArray];
}

+ (BOOL)isWifiNetWork{
    BOOL isWifi;
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    BOOL isWiFi=[M_FIX_NULL_STRING([userDefaults objectForKey:ISWIFI], @0) boolValue];
    AFNetworkReachabilityManager *manager=[AFNetworkReachabilityManager sharedManager];
    if (manager.networkReachabilityStatus!=AFNetworkReachabilityStatusReachableViaWiFi && manager.networkReachabilityStatus!=AFNetworkReachabilityStatusNotReachable && !isWiFi){
        isWifi = NO;
    }else{
        isWifi = YES;
    }
    return isWifi;
}

+(void)startButtonAnimate:(UIButton *)button{
    NSMutableArray *imageArray = [NSMutableArray new];
    for (int i = 1; i < 4; i ++) {
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"mic%d.png",i]]];
    }
    [button setImage:[UIImage imageNamed:@"mic2.png"] forState:UIControlStateNormal];
    [button.imageView setAnimationImages:[imageArray copy]];
    [button.imageView setAnimationDuration:0.5];
    [button.imageView startAnimating];
}
+(void)stopButtonAnimate:(UIButton*)button{
    [button.imageView stopAnimating];
}

+(NSInteger)columnWithInteger:(NSInteger)number{
    NSInteger column;
    NSInteger x = (number+1)%2;
    if (x == 0) {
        column = 1;
    }else{
        column = 0;
    }
    return column;
}
+(NSInteger)rowWithInteger:(NSInteger)number{
    NSInteger row;
    NSInteger x = (number+1)%2;
    if (x == 0) {
        row = 1;
    }else{
        row = 0;
    }
    return row;
}
+(void)gotoAppstoreComment{
    NSString *reviewURL = [templateReviewURL stringByReplacingOccurrencesOfString:@"APP_ID" withString:[NSString stringWithFormat:@"%@", AppID]];
    // iOS 7 needs a different templateReviewURL @see https://github.com/arashpayan/appirater/issues/131
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.1) {
        reviewURL = [templateReviewURLiOS7 stringByReplacingOccurrencesOfString:@"APP_ID" withString:[NSString stringWithFormat:@"%@", AppID]];
    }
    // iOS 8 needs a different templateReviewURL also @see https://github.com/arashpayan/appirater/issues/182
    else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        reviewURL = [templateReviewURLiOS8 stringByReplacingOccurrencesOfString:@"APP_ID" withString:[NSString stringWithFormat:@"%@", AppID]];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:reviewURL]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
    }
}
+(NSString*)fullString:(NSString*)string withMaxIndex:(NSInteger)max{
    NSString *fullString = string;
    for (int i = 0; i<(max-string.length); i++) {
        fullString = [fullString stringByAppendingString:@" "];
    }
    return fullString;
}

+(UIVisualEffectView *)addBlurEffectViewOnView:(UIView*)view frame:(CGRect)frame effectWithStyle:(UIBlurEffectStyle)style{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    [view addSubview:effectView];
    return effectView;
}
#pragma CATransition动画实现
+ (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = .3;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = kCAMediaTimingFunctionEaseInEaseOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

//获取当前时间戳
+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
+ (NSString *)getDateStringWithTime:(NSInteger)time dateFormat:(NSString*)dateFormat{
    NSString *str = [NSString stringWithFormat:@"%ld",(long)time];
    NSTimeInterval timeInteval = [str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:timeInteval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:dateFormat];//@"yyyy-MM-dd"
    NSString *currentDateStr = [dateFormatter stringFromDate:detailDate];
    return currentDateStr;
}

//字符串转时间戳 如：2017-4-10 17:15:10
+ (NSInteger)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return [timeStr integerValue];
}

@end





