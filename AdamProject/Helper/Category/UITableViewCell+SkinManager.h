//
//  UITableViewCell+SkinManager.h
//  SYTools
//
//  Created by nplus on 16/6/27.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (SkinManager)
@property (nonatomic,strong,readonly)UIImageView *customSeparator;
-(void)setCustomSeparatorImage:(UIImage *)customSeparatorImage;
-(void)setCustomSeparatorInset:(UIEdgeInsets)inset;
-(void)setCustomSeparatorColor:(UIColor*)color Inset:(UIEdgeInsets)inset;
@end
