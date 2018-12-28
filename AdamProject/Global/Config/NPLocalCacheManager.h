//
//  NPLocalCacheManager.h
//  Jikebaba
//
//  Created by nplus on 15/4/15.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USERFOLDER [NSString stringWithFormat:@"%@/UserCache",DOCUMENT]
#define USERINFO [NSString stringWithFormat:@"%@/UserInfo",USERFOLDER]
#define BANNERS [NSString stringWithFormat:@"%@/Banners",USERFOLDER]
#define FM [NSFileManager defaultManager]
#define IMAGECACHE [NSString stringWithFormat:@"%@/ImageCache",USERFOLDER]
#define QINIUTOKEN [NSString stringWithFormat:@"%@/QiniuToken.text",DOCUMENT]
#define SEARCHLIST [NSString stringWithFormat:@"%@/searchList.text",DOCUMENT]

@interface NPLocalCacheManager : NSObject
//+(BOOL)removeImageCache;

+(BOOL)saveQiniuTokenListData:(id)wrongData;
+(BOOL)isHasQiniuTokenFromLocalCache;
+(id)getQiniuTokenFromLocalCache;

+(BOOL)saveSearchListData:(id)findData;
+(BOOL)isHasSearchListFromLocalCache;
+(id)getSearchListFromLocalCache;

@end
