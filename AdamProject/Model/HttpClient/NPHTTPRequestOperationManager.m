//
//  SYHTTPRequestOperationManager.m
//  TestAutolayout
//
//  Created by nplus on 15/5/28.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "NPHTTPRequestOperationManager.h"
#import "NSObject+Helper.h"
#import <objc/runtime.h>
#import "NSObject+SYCreateSignature.h"
#import "HawkAuth.h"
#define AppKey @"YXA6X2aF"
#define SecretyKey @"jEeWoQe8d1moWXQB"
@interface NPHTTPRequestOperationManager ()
@property(assign,nonatomic)NSInteger operationID;
@property(strong,nonatomic)NSMutableArray *filters;
@end

@interface SYBaseUrlFilter()
@property(nonatomic,copy)NSString *predicator;
@property(nonatomic,copy)NSString *replaceUrl;
@end
@implementation SYBaseUrlFilter
-(id)initBserUrlFilterWithfilterName:(NSString *)name Predicator:(NSString *)predicator ReplaceBaseUrl:(NSString *)replaceBaseUrl;
{
    self=[super init];
    if(self)
    {
        self.predicator=predicator;
        self.replaceUrl=replaceBaseUrl;
        _filterName=name;
    }
    return self;
}

@end

@implementation NPHTTPRequestOperationManager
+(NPHTTPRequestOperationManager*)sharedHTTPRequestOperationManager{
    static NPHTTPRequestOperationManager* _manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[NPHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:kSYWEB_API_URL]];
        _manager.filters=[[NSMutableArray alloc]init];
    });
    return _manager;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self setRequestSerializer:[AFHTTPRequestSerializer serializer]];
        [self setResponseSerializer:[AFJSONResponseSerializer serializer]];
        if([NPUserInfoSingleton shareUserInfoSingleton].token&&![[NPUserInfoSingleton shareUserInfoSingleton].token isEqualToString:@""]){
            [self.requestSerializer setValue:[NPUserInfoSingleton shareUserInfoSingleton].token forHTTPHeaderField:@"token"];
        }
        _operationID=0;
    }
    return self;
}
-(NSURL *)getuseBaseURL:(NSString *)requestType
{
    if(_filters.count==0)
        return self.baseURL;
    else
    {
        __block NSString *baseurlString;
        [_filters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SYBaseUrlFilter *filter=obj;
            NSPredicate *predicate=[NSPredicate predicateWithFormat:filter.predicator];
            if([predicate evaluateWithObject:requestType])
            {
                baseurlString=filter.replaceUrl;
                *stop=YES;
            }
        }];
        if(baseurlString)
            return [NSURL URLWithString:baseurlString];
        else
            return self.baseURL;
    }
}
-(AFHTTPRequestOperation*)buildGetRequestOperationWithType:(NSString *)type
                                                parameters:(NSDictionary*)parameters
                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    return [self buildGetRequestOperationWithType:type
                                       parameters:parameters
                                       andTimeOut:-1
                                          success:success
                                          failure:failure];
    
}
-(AFHTTPRequestOperation*)buildGetRequestOperationWithType:(NSString *)type
                                                parameters:(NSDictionary*)parameters
                                                andTimeOut:(NSTimeInterval)timeout
                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [self buildRequestOperationWithType:type
                                    parameters:parameters
                                        method:SYHttpQuestMethodGet
                                    andTimeOut:timeout
                              IsRemoveSameType:YES
                                       success:success
                                       failure:failure];
}


//- (AFHTTPRequestOperation*)buildRequestOperationWithType:(NSString*)type
//                                              parameters:(NSDictionary*)parameters
//                                                  method:(SYHttpQuestMethod)method
//                                              andTimeOut:(NSTimeInterval)timeout
//                                        IsRemoveSameType:(BOOL)isRemove
//                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//{
//    AFHTTPRequestOperation *operation=nil;
//    if(isRemove)
//        [self removeRequestOperationFromQueueWithType:type];
//
//    //set httpheader
//    NSMutableDictionary *header=[[NSMutableDictionary alloc]init];
//    //判断登录后传token
//    if([NPUserInfoSingleton shareUserInfoSingleton].token&&![[NPUserInfoSingleton shareUserInfoSingleton].token isEqualToString:@""]){
//        [header setObject:[NPUserInfoSingleton shareUserInfoSingleton].token forKey:@"token"];
//    }
//    NSMutableURLRequest *request;
//    switch (method) {
//        case SYHttpQuestMethodGet:
//        {
//            NSError *serializationError = nil;
//            request =[self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters error:&serializationError];
//            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//            [header addEntriesFromDictionary:request.allHTTPHeaderFields];
//            request.allHTTPHeaderFields=header;
//            if (serializationError) {
//                if (failure) {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wgnu"
//                    dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
//                        failure(nil, serializationError);
//                    });
//#pragma clang diagnostic pop
//                }
//            }
//        }
//            break;
//        case SYHttpQuestMethodPost:
//        {
//            NSError *serializationError = nil;
//            request =[self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters  error:&serializationError];
//            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//            [header addEntriesFromDictionary:request.allHTTPHeaderFields];
//            request.allHTTPHeaderFields=header;
//            if (serializationError) {
//                if (failure) {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wgnu"
//                    dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
//                        failure(nil, serializationError);
//                    });
//#pragma clang diagnostic pop
//                }
//            }
//        }
//            break;
//        case SYHttpQuestMethodPut:
//        {
//            NSError *serializationError = nil;
//            request =[self.requestSerializer requestWithMethod:@"PUT" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters  error:&serializationError];
//            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//            [header addEntriesFromDictionary:request.allHTTPHeaderFields];
//            request.allHTTPHeaderFields=header;
//            if (serializationError) {
//                if (failure) {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wgnu"
//                    dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
//                        failure(nil, serializationError);
//                    });
//#pragma clang diagnostic pop
//                }
//            }
//        }
//            break;
//        case SYHttpQuestMethodDelete:
//        {
//            NSError *serializationError = nil;
//            request =[self.requestSerializer requestWithMethod:@"DELETE" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters  error:&serializationError];
//            request.HTTPMethod = @"DELETE";
//            request.HTTPBody = parameters;//dic字典相当于parameters，请求体里的东西
//            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//            [header addEntriesFromDictionary:request.allHTTPHeaderFields];
//            request.allHTTPHeaderFields=header;
//
//            if (serializationError) {
//                if (failure) {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wgnu"
//                    dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
//                        failure(nil, serializationError);
//                    });
//#pragma clang diagnostic pop
//                }
//            }
//        }
//            break;
//        default:
//        {
//            if(failure)
//                failure(nil,[NSError errorWithDomain:@"没处理这个请求形式" code:-1 userInfo:nil]);
//        }
//            break;
//    }
//    if(timeout!=-1)
//        [request setTimeoutInterval:timeout];
//    operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
//    operation.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/x-www-form-urlencoded",@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
//    if(operation)
//    {
//        _operationID++;
//        operation.oprationID=@(_operationID);
//        operation.requestType=type;
//        [self.operationQueue addOperation:operation];
//    }
//    return operation;
//}
//- (AFHTTPRequestOperation*)buildPostRequestOperationWithType:(NSString*)type
//                                                  parameters:(NSDictionary*)parameters
//                                                  AndTimeOut:(NSTimeInterval)timeout
//                                            IsRemoveSameType:(BOOL)isRemove
//                                   constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
//                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//{
//    AFHTTPRequestOperation *operation=nil;
//    if(isRemove)
//        [self removeRequestOperationFromQueueWithType:type];
//    NSError *serializationError = nil;
//
//    //纯文本类型（x-www-form-urlencoded）
//    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters error:&serializationError];
//
//    //key=value类型（form-data）
//    //    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
//
//    //set httpheader
//    NSMutableDictionary *header=[[NSMutableDictionary alloc]init];
//    //判断登录后传token
//    if([NPUserInfoSingleton shareUserInfoSingleton].token&&![[NPUserInfoSingleton shareUserInfoSingleton].token isEqualToString:@""])
//        [header setObject:[NPUserInfoSingleton shareUserInfoSingleton].token forKey:@"token"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    request.allHTTPHeaderFields=header;
//
//    if (serializationError) {
//        if (failure) {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wgnu"
//            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
//                failure(nil, serializationError);
//            });
//#pragma clang diagnostic pop
//        }
//        return nil;
//    }
//    if(timeout!=-1)
//        [request setTimeoutInterval:timeout];
//    operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
//    operation.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/x-www-form-urlencoded",@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
//    if(operation)
//    {
//        _operationID++;
//        operation.oprationID=@(_operationID);
//        operation.requestType=type;
//        [self.operationQueue addOperation:operation];
//    }
//    return operation;
//}


- (AFHTTPRequestOperation*)buildRequestOperationWithType:(NSString*)type
                                              parameters:(NSDictionary*)parameters
                                                  method:(SYHttpQuestMethod)method
                                              andTimeOut:(NSTimeInterval)timeout
                                        IsRemoveSameType:(BOOL)isRemove
                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation=nil;
    if(isRemove)
        [self removeRequestOperationFromQueueWithType:type];

    //set httpheader
    NSMutableDictionary *header=[[NSMutableDictionary alloc]init];
    
    //判断登录后传token
//    if([NPUserInfoSingleton shareUserInfoSingleton].token&&![[NPUserInfoSingleton shareUserInfoSingleton].token isEqualToString:@""])
//        [header setObject:[NPUserInfoSingleton shareUserInfoSingleton].token forKey:@"token"];
    
    NSMutableURLRequest *request;
    NSError *serializationError = nil;

    switch (method) {
        case SYHttpQuestMethodGet://GET请求
        {
            request =[self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters error:&serializationError];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [header addEntriesFromDictionary:request.allHTTPHeaderFields];
            request.allHTTPHeaderFields=header;
        }
            break;
        case SYHttpQuestMethodPost://POST请求
        {
            request =[self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters  error:&serializationError];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [header addEntriesFromDictionary:request.allHTTPHeaderFields];
            request.allHTTPHeaderFields=header;
        }
            break;
        case SYHttpQuestMethodPut://PUT请求
        {
            self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
            request =[self.requestSerializer requestWithMethod:@"PUT" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters  error:&serializationError];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [header addEntriesFromDictionary:request.allHTTPHeaderFields];
            request.allHTTPHeaderFields=header;
        }
            break;
        case SYHttpQuestMethodDelete://DELETE请求
        {
            self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
            request =[self.requestSerializer requestWithMethod:@"DELETE" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters  error:&serializationError];
            [request setValue:@"adele/dev_owner.json?method=del" forHTTPHeaderField:@"Content-Type"];
            [header addEntriesFromDictionary:request.allHTTPHeaderFields];
            request.allHTTPHeaderFields=header;
        }
            break;
        default:
        {
            if(failure)
                failure(nil,[NSError errorWithDomain:@"没处理这个请求形式" code:-1 userInfo:nil]);
        }
            break;
    }
    
    //公用体
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
    }
    
    if(timeout!=-1)
        [request setTimeoutInterval:timeout];
    operation.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/x-www-form-urlencoded",@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    
    NSString *urlString = [[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString];
    if (method == SYHttpQuestMethodPut) {
        operation = [self PUT:urlString parameters:parameters success:success failure:failure];

    }else if (method == SYHttpQuestMethodDelete){
        
        operation = [self DELETE:urlString parameters:parameters success:success failure:failure];
        
    }else{
        operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
        
        if(operation)
        {
            _operationID++;
            operation.oprationID=@(_operationID);
            operation.requestType=type;
            [self.operationQueue addOperation:operation];
        }
    }
    return operation;
}

- (AFHTTPRequestOperation*)buildPostRequestOperationWithType:(NSString*)type
                                                  parameters:(NSDictionary*)parameters
                                                  AndTimeOut:(NSTimeInterval)timeout
                                            IsRemoveSameType:(BOOL)isRemove
                                   constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation=nil;
    if(isRemove)
        [self removeRequestOperationFromQueueWithType:type];
    NSError *serializationError = nil;

    //纯文本类型（x-www-form-urlencoded）
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters error:&serializationError];

    //key=value类型（form-data）
    //    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:type relativeToURL:[self getuseBaseURL:type]] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];

    //set httpheader
    NSMutableDictionary *header=[[NSMutableDictionary alloc]init];
    //判断登录后传token
//    if([NPUserInfoSingleton shareUserInfoSingleton].token&&![[NPUserInfoSingleton shareUserInfoSingleton].token isEqualToString:@""])
//        [header setObject:[NPUserInfoSingleton shareUserInfoSingleton].token forKey:@"token"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    request.allHTTPHeaderFields=header;

    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        return nil;
    }
    if(timeout!=-1)
        [request setTimeoutInterval:timeout];
    operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    operation.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/x-www-form-urlencoded",@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    if(operation)
    {
        _operationID++;
        operation.oprationID=@(_operationID);
        operation.requestType=type;
        [self.operationQueue addOperation:operation];
    }
    return operation;
}

-(NSString *)createReuqestURL:(NSURL *)requestUrl
                       Method:(NSString *)method
                         Time:(NSDate *)time
{
    NSString *token=nil;
    //    [token appendString:AppKey];
    //    [token appendFormat:@"_%@", [NSObject createSgnatureWithParams:params TimeStamp:time KeyString:SecretyKey]];
    HawkAuth *auth=[[HawkAuth alloc]init];
    HawkCredentials *cre=[[HawkCredentials alloc]initWithHawkId:AppKey withKey:SecretyKey withAlgorithm:CryptoAlgorithmSHA256];
    auth.credentials=cre;
    auth.method=method;
    auth.timestamp=time;
    auth.nonce=[self getNonce];
    auth.port=@(80);
    auth.host=requestUrl.host;
    if(requestUrl.query&&![requestUrl.query isEqualToString:@""])
        auth.requestUri=[NSString stringWithFormat:@"%@?%@",requestUrl.path,[requestUrl.query stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    else
    {
        auth.requestUri=requestUrl.path;
    }
    token=[[auth requestHeader] stringByReplacingOccurrencesOfString:@"Authorization:" withString:@""];
    return token;
}
- (NSString *)hyb_URLEncode:(NSString *)query {
    NSString *newString =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)query,
                                                              NULL,
                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    
    return nil;
}
-(NSString *)getNonce
{
    NSMutableString *nonce=[[NSMutableString alloc]init];
    NSArray *randomloop =@[@(0),@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),
                           @"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",
                           @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    for (int i=0; i<6; i++) {
        int x = arc4random() % 62;
        id object=[randomloop objectAtIndex:x];
        [nonce appendString:[NSString stringWithFormat:@"%@",object]];
    }
    return nonce;
    
}

-(void)removeRequestOperationFromQueueWithType:(NSString *)type
{
    NSPredicate *predicate=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"requestType == '%@'",type]];
    NSArray *array= [self.operationQueue.operations filteredArrayUsingPredicate:predicate];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        AFHTTPRequestOperation *operation =obj;
        if(!operation.isFinished)
        {
            [operation setCompletionBlockWithSuccess:nil failure:nil];
            [operation cancel];
        }
    }];
}
-(void)removeRequestOperationFromQueueWithOperationID:(NSInteger)operationID
{
    NSPredicate *predicate=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"oprationID == %@",@(operationID)]];
    NSArray *array= [self.operationQueue.operations filteredArrayUsingPredicate:predicate];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        AFHTTPRequestOperation *operation =obj;
        if(!operation.isFinished)
        {
            [operation setCompletionBlockWithSuccess:nil failure:nil];
            [operation cancel];
        }
    }];
    
}
-(void)addBaseUrlFilter:(SYBaseUrlFilter *)baseUrlFilter
{
    [_filters addObject:baseUrlFilter];
}
-(void)removeFilterWithName:(NSString *)name
{
    NSArray *somefilters=[_filters filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"filterName == %@",name]];
    [somefilters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_filters removeObject:obj];
    }];
}
-(void)removeAllFilter
{
    [_filters removeAllObjects];
}

@end
@implementation AFHTTPRequestOperation (SYHttp)
@dynamic requestType;
static char kPropertyrequestType;
- (NSString *) requestType
{
    return (NSString *)objc_getAssociatedObject(self, &kPropertyrequestType );
}
- (void) setRequestType:(NSString *)requestType
{
    objc_setAssociatedObject(self, &kPropertyrequestType,requestType ,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@dynamic oprationID;
static char kPropertyOprationID;
- (NSNumber *)oprationID
{
    return (NSNumber *)objc_getAssociatedObject(self, &kPropertyOprationID );
}
- (void)setOprationID:(NSNumber*)oprationID
{
    objc_setAssociatedObject(self, &kPropertyOprationID,oprationID ,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

