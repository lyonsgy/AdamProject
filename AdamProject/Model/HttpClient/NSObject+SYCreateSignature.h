//
//  NSObject+SYCreateSignature.h
//  Test
//
//  Created by nplus on 16/2/26.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SYCreateSignature)
+(NSString *)createSgnatureWithParams:(NSDictionary *)params
                            TimeStamp:(NSString *)timestamp
                            KeyString:(NSString *)keyString;
@end
