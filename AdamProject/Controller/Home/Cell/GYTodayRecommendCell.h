//
//  GYTodayRecommendCell.h
//  AdamProject
//
//  Created by lyons on 2018/12/28.
//  Copyright © 2018 lyons. All rights reserved.
//

#import "QMUITableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GYTodayRecommendCell : QMUITableViewCell

@property(nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UILabel *timeLabel;

- (void)renderWithNameText:(NSString *)nameText contentText:(NSString *)contentText;


@end

NS_ASSUME_NONNULL_END
