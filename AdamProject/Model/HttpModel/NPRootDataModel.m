//
//  SYRootDataModel.m
//  Jikebaba
//
//  Created by nplus on 15/7/20.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "NPRootDataModel.h"
#import "NSObject+isBaseType.h"
#import "NSObject+Helper.h"
@implementation NPRootDataModel


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

//+(void)load
//{
//    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(debugDescription)), class_getInstanceMethod([self class], @selector(syModel_description)));
//}
//-(NSString *)syModel_description
//{
//    if(![self isKindOfClass:[SYRootDataModel class]])
//    {
//        return [self syModel_description];
//    }
//    return [[NSObject getProperty:self] jsonString];
//}


@end
