//
//  NSDictionary+SafeAccess.h
//  IOS-Categories
//
//  Created by Jakey on 15/1/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeAccess)
- (NSString*)systringForKey:(NSString*)key;

- (NSNumber*)synumberForKey:(NSString*)key;

- (NSArray*)syarrayForKey:(NSString*)key;

- (NSDictionary*)sydictionaryForKey:(NSString*)key;

- (NSInteger)syintegerForKey:(id)key;

- (BOOL)syboolForKey:(id)key;

- (int16_t)int16ForKey:(id)key;

- (int32_t)int32ForKey:(id)key;

- (int64_t)int64ForKey:(id)key;

- (short)syshortForKey:(id)key;

- (float)syfloatForKey:(id)key;

- (double)sydoubleForKey:(id)key;

@end
