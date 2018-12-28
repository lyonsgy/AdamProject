//
//  UIButton+UI.h
//  SYUI
//
//  Created by Syousoft on 16/5/23.
//  Copyright © 2016年 Syousoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UI)
@property (nonatomic) NSInteger sy_titleColorHex;
@property (nonatomic) CGFloat sy_titleFont;

-(void)setBackgroundImageWithHexs:(NSArray *)hexs andStateArray:(NSArray *)states;
-(void)setBackgroundImages:(NSArray *)imageArray andInsets:(UIEdgeInsets)insets;
-(void)setImages:(NSArray *)imageArray;
@end
