//
//  NSMutableArray+Helper.h
//  Jikebaba
//
//  Created by nplus on 15/5/13.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Helper)
@property (nonatomic,strong)NSNumber * limitLength;
-(void)addObjectToLimitArray:(id)anObject;
-(void)addObjectToLimitArrayFromArray:(NSArray *)array;
@end
