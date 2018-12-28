//
//  NSObject+isBaseType.h
//  LogMessage
//
//  Created by nplus on 8/27/14.
//  Copyright (c) 2014 nplus. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSObject (isBaseType)
+(BOOL)isBaseType:(id)object;
+(NSDictionary *)getProperty:(id)object;
@end
