//
//  UIImage+extension.h
//  Redious
//
//  Created by admin on 16/12/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (extension)
//圆形
- (void)was_roundImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor opaque:(BOOL)opaque completion:(void (^)(UIImage *))completion;
//圆角矩阵
- (void)was_roundRectImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor opaque:(BOOL)opaque radius:(CGFloat)radius completion:(void (^)(UIImage *))completion;
+ (UIImage *)captureWithRect:(CGRect)rect Image:(UIImage *)image;
@end

@interface UIImageView (Extension)
//网络延迟下载--圆形 有背景色
- (void)was_setCircleImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)placeholderImage fillColor:(UIColor *)color;
//网络延迟下载--圆形矩阵 有背景色
- (void)was_setRoundRectImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)placeholderImage fillColor:(UIColor *)color cornerRadius:(CGFloat) cornerRadius;

//网络延迟下载--圆形    背景色为透明 无背景色
- (void)was_setCircleImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)placeholderImage;
//网络延迟下载--圆形矩阵 背景色为透明 无背景色
- (void)was_setRoundRectImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)placeholderImage cornerRadius:(CGFloat) cornerRadius;
@end

@interface UIButton (Extension)
//button--圆形
- (void)was_setCircleImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)placeholderImage fillColor:(UIColor *)color forState:(UIControlState)state;
//button--圆角矩形
- (void)was_setRoundRectImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)placeholderImage fillColor:(UIColor *)color cornerRadius:(CGFloat) cornerRadius forState:(UIControlState)state;

//button--圆形    背景为透明 无背景色
- (void)was_setCircleImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)placeholderImage forState:(UIControlState)state;
//button--圆角矩形 背景为透明 无背景色
- (void)was_setRoundRectImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)placeholderImage cornerRadius:(CGFloat) cornerRadius forState:(UIControlState)state;

/**
 UIButton加载URL图片自带圆角

 @param url 图片地址
 @param state 按钮状态
 @param placeholder 默认图
 @param radius 圆角大小
 @param fillColor 背景色
 */
- (void)np_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder radius:(CGFloat)radius fillColor:(UIColor *)fillColor;
@end
