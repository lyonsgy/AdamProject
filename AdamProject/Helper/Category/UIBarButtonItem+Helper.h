//
//  UIBarButtonItem+Helper.h
//  Jikebaba
//
//  Created by nplus on 15/7/23.
//  Copyright (c) 2015年 nplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Helper)
+(UIBarButtonItem *)createBarButtonItemWithNorImage:(UIImage *)image
                                       WithPreImage:(UIImage *)preImage
                                         WithHandle:(void (^)(id sender))handler;
@end
