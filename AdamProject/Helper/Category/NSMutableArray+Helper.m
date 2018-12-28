//
//  NSMutableArray+Helper.m
//  Jikebaba
//
//  Created by nplus on 15/5/13.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import "NSMutableArray+Helper.h"

@implementation NSMutableArray (Helper)
ADD_DYNAMIC_PROPERTY(NSNumber *, limitLength, setLimitLength)
-(void)addObjectToLimitArray:(id)anObject
{
    if(self.limitLength.integerValue<=0)
        return;
    if(self.count>=self.limitLength.integerValue)
    {
        [self removeObjectsInRange:NSMakeRange(0, self.count-self.limitLength.integerValue+1)];
    }
    [self addObject:anObject];
}
-(void)addObjectToLimitArrayFromArray:(NSArray *)array
{
    if(self.limitLength.integerValue<=0)
        return;
    if(array.count>=self.limitLength.integerValue)
    {
        [self removeAllObjects];
        [self addObjectsFromArray:[array subarrayWithRange:NSMakeRange(array.count-self.limitLength.integerValue, self.limitLength.integerValue)]];
    }else
    {
        if((self.count+array.count)>self.limitLength.integerValue)
        {
            [self removeObjectsInRange:NSMakeRange(0,(self.count+array.count)-self.limitLength.integerValue)];
        }
        [self addObjectsFromArray:array];
    }
}
@end
