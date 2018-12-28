//
//  NPConfigManager.m
//  Jikebaba
//
//  Created by nplus on 16/4/15.
//  Copyright © 2016年 Syousoft2. All rights reserved.
//

#import "NPConfigManager.h"
#import "NPLocalCacheManager.h"
#import "NSDictionary+SafeAccess.h"
@implementation NPConfigManager
+(instancetype)shareConfigManager
{
    static NPConfigManager *configManager=nil;;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configManager=[[NPConfigManager alloc]init];
    });
    return configManager;
}
-(void)setAPPConfig
{
    //http
    _httpManager=[NPHttpManager shareHttpManager];
    [_httpManager registerURL:@[@"multi",@"simple",@"detail"] WithType:SYHttpMethodGet];
    [_httpManager registerURL:@[@"create",@"store",@"edit",@"update",@"delete",@"put"] WithType:SYHttpMethodPost];
    //上线NO
    _httpManager.isDebug=NO;
    
    NSArray *messageArray=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SYRequestMessageList" ofType:@"plist"]];
    [messageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic=obj;
#if DEBUG
        NSAssert([dic valueForKey:@"message"]!=nil, @"提示信息不能为空");
        NSAssert([dic valueForKey:@"url"]!=nil, @"注册url不能为空");
#endif
        [_httpManager registerMessage:[dic systringForKey:@"message"] ForURL:[dic systringForKey:@"url"] ForHttpCode:[dic syintegerForKey:@"httpcode"]  ForParamKey:[dic systringForKey:@"key"] ForErrorCode:[dic systringForKey:@"errorcode"]];
    }];
    
//    [_httpManager registerSuccessMode:@"SYOrderDetail" ForURL:SYRequestOrderCreateURL IsArray:NO];
//    [_httpManager registerSuccessMode:@"SYRefundOrderList" ForURL:SYRequestOrderRefundListURL IsArray:NO];
//    [_httpManager registerSuccessMode:@"SYOrderDetail" ForURL:SYRequestLastOrderURL IsArray:NO];
//    [_httpManager registerSuccessMode:@"SYTag" ForURL:SYRequestTagCreateURL IsArray:NO];
//    
//    //cache
//    [NPLocalCacheManager createUserCacheFolder];
}

@end
