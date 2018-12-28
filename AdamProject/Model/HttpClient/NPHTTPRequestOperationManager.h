//
//  SYHTTPRequestOperationManager.h
//  TestAutolayout
//
//  Created by nplus on 15/5/28.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
typedef NS_ENUM(NSUInteger, SYHttpQuestMethod) {
    SYHttpQuestMethodGet=0,
    SYHttpQuestMethodPost,
    SYHttpQuestMethodPut,
    SYHttpQuestMethodDelete,
};
@class SYBaseUrlFilter;
@interface NPHTTPRequestOperationManager : AFHTTPRequestOperationManager
-(AFHTTPRequestOperation*)buildGetRequestOperationWithType:(NSString *)type
                                                parameters:(NSDictionary*)parameters
                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
-(AFHTTPRequestOperation*)buildGetRequestOperationWithType:(NSString *)type
                                                parameters:(NSDictionary*)parameters
                                                andTimeOut:(NSTimeInterval)timeout
                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (AFHTTPRequestOperation*)buildRequestOperationWithType:(NSString*)type
                                              parameters:(NSDictionary*)parameters
                                                  method:(SYHttpQuestMethod)method
                                              andTimeOut:(NSTimeInterval)timeout
                                        IsRemoveSameType:(BOOL)isRemove
                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (AFHTTPRequestOperation*)buildPostRequestOperationWithType:(NSString*)type
                                              parameters:(NSDictionary*)parameters
                                              AndTimeOut:(NSTimeInterval)timeout
                                        IsRemoveSameType:(BOOL)isRemove
                               constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
-(void)removeRequestOperationFromQueueWithType:(NSString *)type;
-(void)removeRequestOperationFromQueueWithOperationID:(NSInteger)operationID;
+(NPHTTPRequestOperationManager*)sharedHTTPRequestOperationManager;

-(void)addBaseUrlFilter:(SYBaseUrlFilter *)baseUrlFilter;
-(void)removeFilterWithName:(NSString *)name;
-(void)removeAllFilter;
@end
@interface SYBaseUrlFilter : NSObject
@property (nonatomic,copy,readonly)NSString *filterName;
-(id)initBserUrlFilterWithfilterName:(NSString *)name Predicator:(NSString *)predicator ReplaceBaseUrl:(NSString *)replaceBaseUrl;
@end

@interface AFHTTPRequestOperation (SYHttp)
@property (nonatomic,strong)NSNumber *oprationID;
@property (nonatomic,copy)NSString *requestType;
@end
