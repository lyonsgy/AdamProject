//
//  SYRootRequestOperation.h
//  Jikebaba
//
//  Created by nplus on 15/7/20.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPHTTPRequestOperationManager.h"
#import "../../Helper/Category/NSString+Syou.h"
#import "NSObject+Helper.h"
#import "NPConfigManager.h"
#import "NSDictionary+SafeAccess.h"
#import "NPRequestError.h"

@interface NPRootRequestOperation : NSObject

+(void)requestDataWithOprationType:(NSString *)type
                            method:(SYHttpQuestMethod)method
                      AndPassParam:(NSDictionary*)param
                        AndTimeOut:(NSTimeInterval)timeOut
                    AndResultBlock:(void (^)(id responseData,SYReponseError *error))block;

+(void)requestDataWithOprationType:(NSString *)type
                            method:(SYHttpQuestMethod)method
                      AndPassParam:(NSDictionary*)param
                        AndTimeOut:(NSTimeInterval)timeOut
                       AndIsRemove:(BOOL)isRemove
                    AndResultBlock:(void (^)(id responseData,SYReponseError *error))block;

+(void)postDataWithOprationType:(NSString *)type
                      AndPassParam:(NSDictionary*)param
                     AndTimeOut:(NSTimeInterval)timeOut
             AndUploadDataBlock:(void (^)(id <AFMultipartFormData> formData))uploadDataBlock
                    AndResultBlock:(void (^)(id responseData,SYReponseError *error))block;

+(void)newrequestDataWithOprationType:(NSString *)type
                         AndPassParam:(NSDictionary*)param
                       AndResultBlock:(void (^)(SYReponseSuccess *success,SYReponseError *error))block;
@end
