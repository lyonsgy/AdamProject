//
//  NPUser.m
//  Jikebaba
//
//  Created by lyons on 2017/4/6.
//  Copyright © 2017年 NewZhiWei. All rights reserved.
//

#import "NPUser.h"

@implementation NPUser
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"userId":@"id",@"content":@"description"};
}
@end
