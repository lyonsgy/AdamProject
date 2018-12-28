//
//  NPLocalCacheManager.m
//  Jikebaba
//
//  Created by nplus on 15/4/15.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "NPLocalCacheManager.h"

@implementation NPLocalCacheManager

+(BOOL)saveUserInfo:(id)userInfo
{
    return [NSKeyedArchiver archiveRootObject:userInfo toFile:USERINFO];
}
+(id)getUserInfoFromLocalCache
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:USERINFO];
}
+(BOOL)createUserCacheFolder
{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *version=[NPCommonFunction appVersion];
    if([version compare:LastRemoveVersion]!=NSOrderedAscending)
    {
        BOOL value= [[ud valueForKey:LastRemoveVersion] boolValue];
        if(!value)
        {
            NSError *error;
            [FM removeItemAtPath:USERFOLDER error:&error];
            if(error)
            {
                //删除缓存失败
            }else
            {
                //删除缓存成功
            }
            [ud setObject:@(YES) forKey:LastRemoveVersion];
            [ud synchronize];
        }
    }
    
    [ud setObject:version forKey:LastVersion];
    [ud synchronize];
 
    if(![FM fileExistsAtPath:USERFOLDER])
    {
        NSError *error;
        [FM createDirectoryAtPath:USERFOLDER withIntermediateDirectories:YES attributes:nil error:&error];
        if(error)
            return NO;
        else
            return YES;
    }
    return YES;

}
+(NSString *)getImageCachePath
{
    if(![FM fileExistsAtPath:IMAGECACHE])
    {
        NSError *error;
        [FM createDirectoryAtPath:IMAGECACHE withIntermediateDirectories:YES attributes:nil error:&error];
        if(error)
            return nil;
        else
            return IMAGECACHE;
    }
    return IMAGECACHE;
    
}
+(BOOL)removeImageCache
{
    if([FM fileExistsAtPath:IMAGECACHE])
    {
        NSError *error;
        [FM removeItemAtPath:IMAGECACHE error:&error];
        if(error)
        {
            return NO;
        }else
        {
            return YES;
        }
        
    }else
    {
        return YES;
    }
}

+(BOOL)saveBannersToLocal:(id)banners
{
    return [NSKeyedArchiver archiveRootObject:banners toFile:BANNERS];
}
+(NSArray *)getBannersFromLocal
{
    NSArray *array= [NSKeyedUnarchiver unarchiveObjectWithFile:BANNERS];
    if(!array)
        array=[NSArray array];
    return array;
}


+(BOOL)saveQiniuTokenListData:(id)wrongData{
    return [NSKeyedArchiver archiveRootObject:wrongData toFile:QINIUTOKEN];
}

+(BOOL)isHasQiniuTokenFromLocalCache{
    return [FM fileExistsAtPath:QINIUTOKEN];
}

+(id)getQiniuTokenFromLocalCache{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:QINIUTOKEN];
}


+(BOOL)saveSearchListData:(id)findData
{
    return [NSKeyedArchiver archiveRootObject:findData toFile:SEARCHLIST];
}
+(BOOL)isHasSearchListFromLocalCache
{
    return [FM fileExistsAtPath:SEARCHLIST];
}
+(id)getSearchListFromLocalCache
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:SEARCHLIST];
}
@end

