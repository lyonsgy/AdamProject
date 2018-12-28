//
//  NPModelCommentView.h
//  Jikebaba
//
//  Created by NPlus on 2016/12/16.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPlaceholderTextView.h"

@class NPModelCommentView;
@protocol NPModelCommentViewDelegate <NSObject>

-(void)commentViewDidChange:(NSString *)text;
-(void)makeSureBtnClick:(NSString *)text;
-(void)cancellBtnIsClick;
@end

@interface NPModelCommentView : UIView
@property (nonatomic) NSInteger step;
@property (nonatomic, strong) GCPlaceholderTextView *commentTextView;
@property (nonatomic,assign) id <NPModelCommentViewDelegate> delegate;


-(void)showCommentView;
-(void)hideCommentView;
-(void)removeCommentView;
-(void)resetCommentView;

@end
