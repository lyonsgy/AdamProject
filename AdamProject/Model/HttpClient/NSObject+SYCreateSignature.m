//
//  NSObject+SYCreateSignature.m
//  Test
//
//  Created by nplus on 16/2/26.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import "NSObject+SYCreateSignature.h"
#import <CommonCrypto/CommonHMAC.h>
#import "Base64.h"
#import "HawkAuth.h"
@implementation NSObject (SYCreateSignature)
+(NSString *)createSgnatureWithParams:(NSDictionary *)params
                            TimeStamp:(NSString *)timestamp
                            KeyString:(NSString *)keyString
{
  
    NSMutableString * paramsString=[NSMutableString new];
    if(params.count>0)
    {
        NSArray *newAllkeys= [params.allKeys sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        [newAllkeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id value = [params valueForKey:obj];
            if([value isKindOfClass:[NSNumber class]])
            {
                NSNumberFormatter *ft=[NSNumberFormatter new];
                ft.numberStyle=NSNumberFormatterRoundHalfEven;
                [paramsString appendString:[NSString stringWithFormat:@"%@=%@&",obj,value]];
            }else if([value isKindOfClass:[NSDictionary class]]||[value isKindOfClass:[NSArray class]])
            {
                NSString *str=[[[value jsonString]stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                [paramsString appendString:[NSString stringWithFormat:@"%@=%@&",obj,str]];
            }else
            {
                [paramsString appendString:[NSString stringWithFormat:@"%@=%@&",obj,value]];
            }
        }];
        [paramsString deleteCharactersInRange:NSMakeRange(paramsString.length-1, 1)];
    }
    [paramsString appendString:@"\n"];
    [paramsString appendString:timestamp];
    NSData *saltData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *paramData = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH ];

    CCHmac(kCCHmacAlgSHA256, saltData.bytes, saltData.length, paramData.bytes, paramData.length, hash.mutableBytes);
    NSString *temp = [self convertDataToHexStr:hash];
    NSString *base64Hash = [temp base64EncodedString];
    return base64Hash;
}


+(NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

@end
