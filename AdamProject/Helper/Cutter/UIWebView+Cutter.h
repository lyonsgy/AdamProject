//
//  UIWebView+Cutter.h
//  CutterTest
//
//  Created by lyons on 2017/5/5.
//  Copyright © 2017年 myjobsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Cutter)
/**
 *  根据视图尺寸获取视图截屏（一屏无法显示完整）,适用于UIScrollView UITableviewView UICollectionView UIWebView
 *
 *  @return UIImage 截取的图片
 */
- (UIImage *)webViewCutter;
@end
