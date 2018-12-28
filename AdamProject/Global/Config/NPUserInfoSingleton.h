//
//  NPUserInfoSingleton.h
//  Jikebaba
//
//  Created by nplus on 14-5-27.
//  Copyright (c) 2014年 nplus. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NPUser.h"

@interface NPUserInfoSingleton : NSObject<NSCoding>
@property (nonatomic, copy) NSString *token;
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic, copy) NPUser *user;

-(BOOL)saveUserInfoTolocal;
+(NPUserInfoSingleton *)getUserInfoFromlocal;
-(BOOL)resetUserInfo;
+(instancetype)shareUserInfoSingleton;
+(BOOL)removeUserInfoFromlocal;

/**
 获取个人信息

 @param user 个人信息
 @return 成功保存
 */
-(BOOL)getUserInfo:(NPUser*)user;

/**
 保存token

 @param token token
 @return  保存成功
 */
-(BOOL)getToken:(NSString*)token;

@end

