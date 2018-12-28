//
//  SYStarView.h
//  123456
//
//  Created by Syousoft2 on 16/4/5.
//  Copyright © 2016年 Syousoft2. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SYStarButton:UIButton
@property(nonatomic,assign)NSInteger index;
@end

@interface SYStarView : UIView
//default YES (可点击)
@property(nonatomic,assign)BOOL enabled;
@property(nonatomic,assign)NSInteger score;
-(instancetype)initWithFrame:(CGRect)frame withStarWidth:(CGFloat)starWidth withLeftMargin:(CGFloat)leftMargin;
@end
