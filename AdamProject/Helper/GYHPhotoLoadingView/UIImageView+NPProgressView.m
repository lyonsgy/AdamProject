//
//  UIImageView+NPProgressView.m
//  GYHPhotoLoadingView
//
//  Created by lyons on 2017/10/31.
//  Copyright © 2017年 gyh. All rights reserved.
//

#import "UIImageView+NPProgressView.h"
#import "GYHCircleProgressView.h"

#define TAG_PROGRESS_VIEW 149462
static CGFloat const kAnimationTime = .3;
static CGFloat const kProgressViewWidth = 36.0f;
static CGFloat const kProgressViewWidthSmall = 22.0f;
static CGFloat const kProgressStrokeWidth = 1.5f;
static CGFloat const kProgressStrokeWidthSmall = 1.5f;
@implementation UIImageView (NPProgressView)
@dynamic progressViewType;

- (void)addProgressViewWithType:(NPProgressViewType)progressViewType{
    GYHCircleProgressView *progressV = (GYHCircleProgressView *)[self viewWithTag:TAG_PROGRESS_VIEW];
    if (!progressV) {
        WS(wself)
        CGFloat progressViewWidth = ((progressViewType==NPProgressViewTypeCircle)?kProgressViewWidth:kProgressViewWidthSmall);
        GYHCircleProgressView *progressView = [[GYHCircleProgressView alloc]initWithFrame:CGRectMake((self.tz_width-progressViewWidth)/2, (self.tz_height-progressViewWidth)/2, progressViewWidth, progressViewWidth)];
        [self addSubview:progressView];
        [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(wself);
            make.width.height.mas_equalTo(progressViewWidth);
        }];
        progressView.tag = TAG_PROGRESS_VIEW;
        //在这里可以修改一些属性
        switch (progressViewType) {
            case NPProgressViewTypeCircle:
            {
                progressView.progressStrokeWidth = kProgressStrokeWidth;
            }
                break;
            case NPProgressViewTypeCircleSmall:
            {
                progressView.progressStrokeWidth = kProgressStrokeWidthSmall;
            }
                break;
            default:
                break;
        }
        progressView.progressColor = [UIColor colorWithHex:0x646464];
        progressView.progressTrackColor = [UIColor whiteColor];
    }
}

- (void)updateProgress:(CGFloat)progress{
    GYHCircleProgressView *progressView = (GYHCircleProgressView *)[self viewWithTag:TAG_PROGRESS_VIEW];
    if (progressView) {
        progressView.progressValue = progress;
    }
}

- (void)removeProgressView{
    GYHCircleProgressView *progressView = (GYHCircleProgressView *)[self viewWithTag:TAG_PROGRESS_VIEW];
    if (progressView) {
        progressView.hidden = YES;
        [progressView removeFromSuperview];
    }
}

- (void)sd_setCircleImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder animated:(BOOL)animated
{
    WS(wself)
    [self addProgressViewWithType:NPProgressViewTypeCircle];
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        CGFloat progress = fabs(receivedSize/((CGFloat)expectedSize));
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself updateProgress:progress];
        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [wself removeProgressView];
        if (animated) {
            if (image && cacheType == SDImageCacheTypeNone) {
                CATransition *transition = [CATransition animation];
                transition.type = kCATransitionFade;
                transition.duration = kAnimationTime;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                [wself.layer addAnimation:transition forKey:nil];
            }
        }
    }];
}
- (void)sd_setCircleImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(void(^)(BOOL isFinished,UIImage *image, SDImageCacheType cacheType))completeBlock animated:(BOOL)animated
{
    WS(wself)
    [self addProgressViewWithType:NPProgressViewTypeCircle];
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:0
                    progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                        CGFloat progress = fabs(receivedSize/((CGFloat)expectedSize));
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [wself updateProgress:progress];
                        });
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        [wself removeProgressView];
                        if (animated) {
                            if (image && cacheType == SDImageCacheTypeNone) {
                                CATransition *transition = [CATransition animation];
                                transition.type = kCATransitionFade;
                                transition.duration = kAnimationTime;
                                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                                [wself.layer addAnimation:transition forKey:nil];
                                if (completeBlock) {
                                    completeBlock(YES,image,cacheType);
                                }
                            }else{
                                if (completeBlock) {
                                    completeBlock(YES,image,cacheType);
                                }
                            }
                        }
                    }];
}

- (void)sd_setCircleImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progressViewType:(NPProgressViewType)progressViewType
{
    WS(wself)
    [self addProgressViewWithType:progressViewType];
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:0
                    progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                        CGFloat progress = fabs(receivedSize/((CGFloat)expectedSize));
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [wself updateProgress:progress];
                        });
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        [wself removeProgressView];
                        if (image && cacheType == SDImageCacheTypeNone) {
                            CATransition *transition = [CATransition animation];
                            transition.type = kCATransitionFade;
                            transition.duration = kAnimationTime;
                            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                            [wself.layer addAnimation:transition forKey:nil];
                        }
                    }];
}

- (void)sd_setCircleImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progressViewType:(NPProgressViewType)progressViewType completed:(void(^)(BOOL isFinished,UIImage *image, SDImageCacheType cacheType))completeBlock animated:(BOOL)animated
{
    WS(wself)
    [self addProgressViewWithType:progressViewType];
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:0
                    progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                        
                        CGFloat progress = fabs(receivedSize/((CGFloat)expectedSize));
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [wself updateProgress:progress];
                        });
                        
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                        [wself removeProgressView];
                        if (animated) {
                            if (image && cacheType == SDImageCacheTypeNone) {
                                CATransition *transition = [CATransition animation];
                                transition.type = kCATransitionFade;
                                transition.duration = kAnimationTime;
                                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                                [wself.layer addAnimation:transition forKey:nil];
                                if (completeBlock) {
                                    completeBlock(YES,image,cacheType);
                                }
                            }else{
                                if (completeBlock) {
                                    completeBlock(YES,image,cacheType);
                                }
                            }
                        }else{
                            if (completeBlock) {
                                completeBlock(image,image,cacheType);
                            }
                        }
                        
                    }];
}
@end
