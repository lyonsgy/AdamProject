//
//  SYHttpManager.m
//  Jikebaba
//
//  Created by nplus on 16/4/15.
//  Copyright © 2016年 Syousoft2. All rights reserved.
//

#import "NPHttpManager.h"
#import "NSDictionary+SafeAccess.h"


@interface SYReponseError ()

@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *paramKey;
@property (nonatomic ,copy)NSString *errorCode;
@end

@implementation SYReponseError
-(id)initWithHttpResponseError:(id)reponse URL:(NSString *)url HttpCode:(NSInteger)httpCode
{
    self=[super init];
    if(self)
    {
        if(reponse&&[reponse isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dic=reponse;
            NSString *errorCode=[dic systringForKey:@"code"];
            NSString *errormessage=[dic systringForKey:@"message"];
            NSString *errorKey=[dic systringForKey:@"param"];
            id errorData=[dic valueForKey:@"data"];
//            self.message=[NSString stringWithFormat:@"code:%@ --> message:%@ -->errorKey:%@",errorCode,errormessage,errorKey];
            self.message=errormessage;
            self.paramKey=errorKey;
            self.data=errorData;
            self.errorCode=errorCode;
        }
        self.url=url;
        self.httpCode=httpCode;
        
    }
    return self;
}
-(NSString *)description
{
    NSString *desc =[NSString stringWithFormat:@"\n--------- code:%@ \n errorCode:%ld \n message:%@ \n errorKey:%@ \n----------",self.errorCode,self.httpCode,self.message,self.paramKey];
    return desc;
}
@end

@interface SYReponseSuccess ()
@property(nonatomic,assign)NSInteger httpCode;
@property (nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *modeClass;
@property(nonatomic,assign)BOOL isArray;
@end

@implementation SYReponseSuccess

-(id)initWithHttpResponseSuccess:(id)reponse URL:(NSString *)url HttpCode:(NSInteger)httpCode
{
    self=[super init];
    if(self)
    {
        self.data=reponse;
        self.httpCode=httpCode;
        self.url=url;
    }
    return self;
}

@end

@interface NPHttpManager ()
@property(nonatomic,strong)NSMutableSet *httpReuqeustGet;
@property(nonatomic,strong)NSMutableSet *httpReuqeustPost;
@property(nonatomic,strong)NSMutableSet *httpReuqeustDelete;
@property(nonatomic,strong)NSMutableSet *httpReuqeustPut;

@property(nonatomic,strong)NSMutableArray *showMessageArray;
@property(nonatomic,strong)NSMutableArray *successModeArray;
@end

@implementation NPHttpManager
+(instancetype)shareHttpManager
{
    
    static NPHttpManager *manager=nil;;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[NPHttpManager alloc]init];
        manager.httpReuqeustDelete=[NSMutableSet new];
        manager.httpReuqeustPost=[NSMutableSet new];
        manager.httpReuqeustPut=[NSMutableSet new];
        manager.httpReuqeustGet=[NSMutableSet new];
        manager.showMessageArray=[NSMutableArray new];
        manager.successModeArray=[NSMutableArray new];
        manager.isDebug=YES;
    });
    return manager;
}
-(void)registerURL:(NSArray *)url WithType:(SYHttpMethod)httpMethod
{
    switch (httpMethod) {
        case SYHttpMethodGet:
        {
            [_httpReuqeustGet addObjectsFromArray:url];
        }
            break;
        case SYHttpMethodPost:
        {
            [_httpReuqeustPost addObjectsFromArray:url];
        }
            break;
            
        default:
            break;
    }
}
-(SYHttpMethod)getHttpMethodFromURL:(NSString *)url
{
    NSString *method=[url lastPathComponent];
    if([_httpReuqeustGet containsObject:method])
    {
        return SYHttpMethodGet;
    }
    if([_httpReuqeustPost containsObject:method])
    {
        return SYHttpMethodPost;
    }
    return SYHttpMethodGet;//默认
}
-(SYReponseError *)getHttpErrorForm:(SYReponseError *)error
{
    
    if(_isDebug)
    {
        if(error.httpCode==409)
        {
            error.action = SYErrorAction409;
            return error;
        }else
        {
            error.action = SYErrorActionAlert;
            return error;
        }
    }
    else
    {
        //step1
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.errorCode == %@ AND SELF.url == %@ AND SELF.paramKey == %@",error.errorCode,error.url,error.paramKey];
        NSArray *array=[_showMessageArray filteredArrayUsingPredicate:predicate];
        if(array.count==0)
        {
            //step2 包括:paramKey:@""
            predicate=[NSPredicate predicateWithFormat:@"SELF.httpCode == %d AND SELF.url == %@ AND SELF.paramKey == %@",error.httpCode,error.url,error.paramKey];
            array=[_showMessageArray filteredArrayUsingPredicate:predicate];
            if(array.count==0)
            {
                //step3
                predicate=[NSPredicate predicateWithFormat:@"SELF.url == %@ AND SELF.paramKey == %@ AND SELF.errorCode == \"\" ",error.url,error.paramKey];
                array=[_showMessageArray filteredArrayUsingPredicate:predicate];
                if(array.count==0)
                {
                    //step4
                    predicate=[NSPredicate predicateWithFormat:@"SELF.url == %@ AND SELF.paramKey ==\"\" AND SELF.errorCode == \"\" AND SELF.httpCode ==\"\" ",error.url];
                    array=[_showMessageArray filteredArrayUsingPredicate:predicate];
                }
            }
        }
        
        if(array.count>0)
        {
            SYReponseError *customerror=[array firstObject];
            customerror.data=error.data;
            return customerror;
        }else
        {
            if(error.httpCode==409)
            {
                error.action = SYErrorAction409;
            }else
            {
                error.message = NetWorkError;
                error.action = SYErrorActionAlert;
            }
            return error;
        }
        
    }
}

+(void)serializeDataWithUrl:(NSString *)url
                  ModeClass:(Class)modeClass
               ResponseData:(id)responseData
                ReturnBlock:(void(^)(SYReponseSuccess *success,SYReponseError *error))returnBlock
{
    SYReponseSuccess *suceessR=[[SYReponseSuccess alloc]initWithHttpResponseSuccess:nil URL:url HttpCode:200];
    if(responseData)
    {
        id modelData=nil;
        if([[modeClass new] isKindOfClass:[NPRootDataModel class]])
        {
            if([responseData isKindOfClass:[NSArray class]])
            {
                modelData=[modeClass arrayOfModelsFromDictionaries:responseData];
            }else
            {
                modelData=[[modeClass alloc]initWithDictionary:responseData error:nil];
            }
        }else
        {
            modelData=responseData;
        }
        if(modelData)
        {
            suceessR.data=modelData;
            returnBlock(suceessR,nil);
        }else
        {
            suceessR.message=@"返回数据解析失败";
            returnBlock(suceessR,nil);
        }

    }else
    {
        suceessR.message=@"返回数据为NULL";
        returnBlock(suceessR,nil);
    }
  
}

#pragma mark ---property----
-(BOOL)isDebug
{
#ifdef DEBUG
    return _isDebug;
#else
    return NO;
#endif
}
#pragma mark ---Message----
-(void)registerMessage:(NSString *)message
                ForURL:(NSString *)url
           ForHttpCode:(NSInteger)httpCode
           ForParamKey:(NSString *)paramKey
          ForErrorCode:(NSString *)errorCode
{

    SYReponseError *error=[[SYReponseError alloc]init];
    error.message=message;
    error.url=url;
    error.httpCode=httpCode;
    error.paramKey=paramKey;
    error.action=SYErrorActionAlert;
    error.errorCode=errorCode;
    [self.showMessageArray addObject:error];
}
-(void)registerMessage:(NSString *)message
                ForURL:(NSString *)url
           ForHttpCode:(NSInteger)httpCode
           ForParamKey:(NSString *)paramKey
          ForErrorCode:(NSString *)errorCode
           ErrorAction:(SYErrorAction)errorAction
{
    SYReponseError *error=[[SYReponseError alloc]init];
    error.message=message;
    error.url=url;
    error.httpCode=httpCode;
    error.paramKey=paramKey;
    error.action=errorAction;
    error.errorCode=errorCode;
    [self.showMessageArray addObject:error];
}
-(void)register409ErrorWithURL:(NSString *)url
                   ForHttpCode:(NSInteger)httpCode
{
    SYReponseError *error=[[SYReponseError alloc]init];
    error.url=url;
    error.httpCode=httpCode;
    error.action=SYErrorAction409;
    [self.showMessageArray addObject:error];
}

-(void)registerSuccessMode:(NSString *)ModeClass
                    ForURL:(NSString *)url
                   IsArray:(BOOL)isArray
{
    SYReponseSuccess *success=[[SYReponseSuccess alloc]init];
    success.modeClass=ModeClass;
    success.url=url;
    success.isArray=isArray;
    [_successModeArray addObject:success];
}
-(SYReponseSuccess *)getHttpSuccessFrom:(SYReponseSuccess *)success
{
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.url == %@ ",success.url];
    NSArray *array=[_successModeArray filteredArrayUsingPredicate:predicate];
    if(array.count>0&&success.httpCode!=SYHTTPCodeSuccessNodata)
    {
        SYReponseSuccess *rsuccess=[array firstObject];
        rsuccess.httpCode=success.httpCode;
        Class modeClass =NSClassFromString(rsuccess.modeClass);
        if(rsuccess.isArray)
        {
            if([[modeClass new]isKindOfClass:[NPRootDataModel class]])
            {
                rsuccess.data=[modeClass arrayOfModelsFromDictionaries:success.data];
                return rsuccess;
            }
            
        }else
        {
            if([[modeClass new]isKindOfClass:[NSString class]])
            {
                return rsuccess;
            }else if([[modeClass new]isKindOfClass:[NPRootDataModel class]])
            {
                rsuccess.data=[[modeClass alloc]initWithDictionary:success.data error:nil];
                return rsuccess;
            }
        }
    }
    return success;
}
@end



