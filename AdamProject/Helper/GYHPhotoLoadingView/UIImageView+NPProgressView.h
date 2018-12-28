//
//  UIImageView+NPProgressView.h
//  GYHPhotoLoadingView
//
//  Created by lyons on 2017/10/31.
//  Copyright © 2017年 gyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

typedef enum {
    NPProgressViewTypeCircle,
    NPProgressViewTypeCircleSmall
}NPProgressViewType;

@interface UIImageView (NPProgressView)

/**
 进度条样式
 */
@property (nonatomic)NPProgressViewType progressViewType;

/**
 环形加载图片动画

 @param url url
 @param placeholder placeholder
 @param animated animated
 */
- (void)sd_setCircleImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder animated:(BOOL)animated;

/**
 环形加载图片动画（回调）

 @param url url
 @param placeholder placeholder
 @param completeBlock 回调
 @param animated animated
 */
- (void)sd_setCircleImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(void(^)(BOOL isFinished,UIImage *image, SDImageCacheType cacheType))completeBlock animated:(BOOL)animated;

/**
 环形加载图片动画

 @param url url
 @param placeholder placeholder
 */
- (void)sd_setCircleImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progressViewType:(NPProgressViewType)progressViewType;

/**
 环形加载图片动画（回调）
 
 @param url url
 @param placeholder placeholder
 @param completeBlock 回调
 */
- (void)sd_setCircleImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progressViewType:(NPProgressViewType)progressViewType completed:(void(^)(BOOL isFinished,UIImage *image, SDImageCacheType cacheType))completeBlock animated:(BOOL)animated;

@end
