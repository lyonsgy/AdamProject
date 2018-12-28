//
//  SYHttpManager.h
//  Jikebaba
//
//  Created by nplus on 16/4/15.
//  Copyright © 2016年 Syousoft2. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SYHttpMethod) {
    SYHttpMethodGet=0,
    SYHttpMethodPost,
};
typedef NS_ENUM(NSUInteger, SYErrorAction) {
    SYErrorActionAlert=0,
    SYErrorActionRestUser,
    SYErrorAction409
};
typedef NS_ENUM(NSUInteger, SYSuccessAction) {
    SYSuccessActionAlert=0,
};
@class SYReponseError,SYReponseSuccess;
@interface NPHttpManager : NSObject
{
    
}
@property (nonatomic,assign)BOOL isDebug;
+(instancetype)shareHttpManager;
-(void)registerURL:(NSArray *)url WithType:(SYHttpMethod)httpMethod;
-(SYHttpMethod)getHttpMethodFromURL:(NSString *)url;

//error
-(void)registerMessage:(NSString *)message
                ForURL:(NSString *)url
           ForHttpCode:(NSInteger)httpCode
           ForParamKey:(NSString *)paramKey
          ForErrorCode:(NSString *)errorCode;

-(void)registerMessage:(NSString *)message
                ForURL:(NSString *)url
           ForHttpCode:(NSInteger)httpCode
           ForParamKey:(NSString *)paramKey
          ForErrorCode:(NSString *)errorCode
           ErrorAction:(SYErrorAction)errorAction;

-(SYReponseError *)getHttpErrorForm:(SYReponseError *)error;

//successs
-(void)registerSuccessMode:(NSString *)ModeClass
                    ForURL:(NSString *)url
                   IsArray:(BOOL)isArray;
-(SYReponseSuccess*)getHttpSuccessFrom:(SYReponseSuccess *)success;

//serializeDataError
/**
 *  returnBlock 中error弃用
 *
 */
+(void)serializeDataWithUrl:(NSString *)url
                      ModeClass:(Class)modeClass
                   ResponseData:(id)responseData
                    ReturnBlock:(void(^)(SYReponseSuccess *success,SYReponseError *error))returnBlock;
@end

@interface SYReponseError:NSObject
@property (nonatomic,copy)NSString *message;
@property (nonatomic,strong)id data;
@property (nonatomic,assign)SYErrorAction action;
@property (nonatomic,assign)NSInteger httpCode;
-(id)initWithHttpResponseError:(id)reponse URL:(NSString *)url HttpCode:(NSInteger)httpCode;
@end

@interface SYReponseSuccess:NSObject
@property (nonatomic,strong)id data;
@property (nonatomic,copy)NSString *message;
@property (nonatomic,assign)SYSuccessAction action;
-(id)initWithHttpResponseSuccess:(id)reponse URL:(NSString *)url HttpCode:(NSInteger)httpCode;
@end
