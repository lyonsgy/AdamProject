//
//  NSObject+Helper.m
//  Jikebaba
//
//  Created by nplus on 15/7/27.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "NSObject+Helper.h"

@implementation NSObject (Helper)
-(NSString *)jsonString{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
@end
