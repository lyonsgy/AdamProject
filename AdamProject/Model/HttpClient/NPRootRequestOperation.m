//
//  SYRootRequestOperation.m
//  Jikebaba
//
//  Created by nplus on 15/7/20.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "NPRootRequestOperation.h"

@implementation NPRootRequestOperation
+(void)requestDataWithOprationType:(NSString *)type
                            method:(SYHttpQuestMethod)method
                      AndPassParam:(NSDictionary*)param
                        AndTimeOut:(NSTimeInterval)timeOut
                    AndResultBlock:(void (^)(id responseData,SYReponseError *error))block
{
    [NPRootRequestOperation requestDataWithOprationType:type method:method AndPassParam:param AndTimeOut:timeOut AndIsRemove:NO AndResultBlock:block];
}

+(void)postDataWithOprationType:(NSString *)type
                   AndPassParam:(NSDictionary*)param
                     AndTimeOut:(NSTimeInterval)timeOut
             AndUploadDataBlock:(void (^)(id <AFMultipartFormData> formData))uploadDataBlock
                 AndResultBlock:(void (^)(id responseData,SYReponseError *error))block
{
    [[NPHTTPRequestOperationManager sharedHTTPRequestOperationManager]buildPostRequestOperationWithType:type parameters:param AndTimeOut:timeOut IsRemoveSameType:YES constructingBodyWithBlock:uploadDataBlock success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(block)
            block(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        SYReponseError *reponseError=[[SYReponseError alloc]initWithHttpResponseError:operation.responseObject URL:type HttpCode:operation.response.statusCode];
        SYReponseError *newError=[[NPHttpManager shareHttpManager] getHttpErrorForm:reponseError];
        if(block)  block(nil,newError);
    }];
}

+(void)requestDataWithOprationType:(NSString *)type
                            method:(SYHttpQuestMethod)method
                      AndPassParam:(NSDictionary*)param
                        AndTimeOut:(NSTimeInterval)timeOut
                       AndIsRemove:(BOOL)isRemove
                    AndResultBlock:(void (^)(id responseData,SYReponseError *error))block
{
    [[NPHTTPRequestOperationManager sharedHTTPRequestOperationManager] buildRequestOperationWithType:type parameters:param method:method andTimeOut:getTimeOut IsRemoveSameType:isRemove success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(block)
            block(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        SYReponseError *reponseError=[[SYReponseError alloc]initWithHttpResponseError:operation.responseObject URL:type HttpCode:operation.response.statusCode];
        //DLog(@"urL:%@----->%@",type,[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
        SYReponseError *newError=[[NPHttpManager shareHttpManager] getHttpErrorForm:reponseError];
        if(block)  block(nil,newError);
    }];
}

+(void)newrequestDataWithOprationType:(NSString *)type
                         AndPassParam:(NSDictionary*)param
                       AndResultBlock:(void (^)(SYReponseSuccess *success,SYReponseError *error))block
{
    [[NPHTTPRequestOperationManager sharedHTTPRequestOperationManager]buildRequestOperationWithType:type parameters:param method:(SYHttpQuestMethod)[[NPConfigManager shareConfigManager].httpManager getHttpMethodFromURL:type] andTimeOut:getTimeOut IsRemoveSameType:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SYReponseSuccess *success=[[SYReponseSuccess alloc]initWithHttpResponseSuccess:responseObject URL:type HttpCode:operation.response.statusCode];
        SYReponseSuccess*newsuccess=[[NPHttpManager shareHttpManager] getHttpSuccessFrom:success];
        block(newsuccess,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //DLog(@"urL:%@----->%@",type,[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
        SYReponseError *reponseError=[[SYReponseError alloc]initWithHttpResponseError:operation.responseObject URL:type HttpCode:operation.response.statusCode];
        SYReponseError *newError=[[NPHttpManager shareHttpManager] getHttpErrorForm:reponseError];
        if(block)  block(nil,newError);
    }];
}

@end
