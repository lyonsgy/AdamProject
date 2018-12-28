//
//  NPUserInfoSingleton.m
//  Jikebaba
//
//  Created by nplus on 14-5-27.
//  Copyright (c) 2014年 nplus. All rights reserved.
//

#import "NPUserInfoSingleton.h"

#define USERINFOADDRESS @"userInfoAddress.txt"
@implementation NPUserInfoSingleton

+(instancetype)shareUserInfoSingleton
{
    
    static NPUserInfoSingleton *userInfo=nil;;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo=[[self class]getUserInfoFromlocal];
        if(userInfo==nil)
        {
            userInfo = [[[self class] alloc] init];
        }
    });
    return userInfo;
}
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        self.user = [NPUser new];
        self.token = @"";
    }
    return self;
}
-(BOOL)isLogin
{
    if(!_token || [_token isEqualToString:@""] ){
        return NO;
    }else{
        return YES;
    }
}

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.user forKey:@"user"];
    [encoder encodeObject:self.token forKey:@"token"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.user = [decoder decodeObjectForKey:@"user"];
        self.token = [decoder decodeObjectForKey:@"token"];
    }
    return self;
}

-(BOOL)resetUserInfo
{
    self.user = [NPUser new];
    self.token = @"";
    return  [self saveUserInfoTolocal];
}
-(BOOL)saveUserInfoTolocal
{
    return  [NSKeyedArchiver archiveRootObject:self toFile:[NSString stringWithFormat:@"%@/%@",DOCUMENT,USERINFOADDRESS]];
}
+(NPUserInfoSingleton *)getUserInfoFromlocal
{
    NPUserInfoSingleton* saveUserInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",DOCUMENT,USERINFOADDRESS]]];
    return saveUserInfo;
}
+(BOOL)removeUserInfoFromlocal
{
    return [[NSFileManager defaultManager]removeItemAtPath:[NSString stringWithFormat:@"%@/%@",DOCUMENT,USERINFOADDRESS] error:nil];
}

-(BOOL)getUserInfo:(NPUser*)user
{
    self.user = user;
    return [self saveUserInfoTolocal];
}

-(BOOL)getToken:(NSString*)token
{
    self.token = token;
    return [self saveUserInfoTolocal];
}
@end
