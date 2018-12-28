//
//  UINavigationBar+SkinManager.h
//  SYTools
//
//  Created by nplus on 16/6/27.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (SkinManager)
@property (nonatomic,strong,readonly)UIImageView *shadowLineView;
@property (nonatomic,strong,readonly)UIImageView *iconImageView;
-(void)setShadowLineImage:(UIImage *)image;
-(void)setIconImage:(UIImage *)iconImage WithRigthOffset:(CGFloat)rightOffset TopOffset:(CGFloat)topOffset;
@end
