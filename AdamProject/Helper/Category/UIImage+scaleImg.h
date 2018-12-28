//
//  UIImage+scaleImg.h
//  SyouInfoPublish
//
//  Created by Syousoft on 14-3-11.
//  Copyright (c) 2014年 com.syou.info. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (scaleImg)
-(UIImage *)scaleThumbImageWithsize:(CGSize )thumbSize;
-(UIImage *)scaleToSize:(CGSize)size;
+(UIImage *)imageWithName:(NSString *)name AndCapInsets:(UIEdgeInsets)streachCapInsets;
+(UIImage *)addImage:(UIImage *)image toBackImage:(UIImage *)bacKImage;
-(UIImage *)scaleToSizeWithWidth:(CGFloat)width;
-(UIImage *)scaleToSizeWithHeight:(CGFloat)height;
-(NSData *)compressionimageForData;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;


/**
 根据dataString生成二维码

 @param dataString 二维码信息
 @param size 大小
 @return 生成的二维码图片
 */
+ (UIImage *)creatNonInterpolatedUIImageFormData:(NSString *)dataString withSize:(CGFloat)size;

/**
 修改图片颜色

 @param image 输入图片
 @param red R值
 @param green G值
 @param blue B值
 @return 输出图片
 */
+ (UIImage *)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;
+ (UIImage *)addSlaveImage:(UIImage *)slaveImage toMasterImage:(UIImage *)masterImage;
@end
