//
//  SYStackView.h
//  MSGZS
//
//  Created by nplus on 16/1/5.
//  Copyright © 2016年 Syousoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYStackView : UIView
{
    NSMutableArray *_separateLineArray;
}
@property (nonatomic,strong,nonnull)UIView *uplineView;
@property (nonatomic,assign)BOOL isShowSeparateLine;
@property (nonatomic,strong,nullable)UIColor *separateLineColor;

-(void)addStackViews:(nonnull NSArray*)views;
@end
