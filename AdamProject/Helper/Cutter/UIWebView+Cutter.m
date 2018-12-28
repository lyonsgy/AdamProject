//
//  UIWebView+Cutter.m
//  CutterTest
//
//  Created by lyons on 2017/5/5.
//  Copyright © 2017年 myjobsky. All rights reserved.
//

#import "UIWebView+Cutter.h"
#import "UIView+Cutter.h"

@implementation UIWebView (Cutter)
/**
 *  根据视图尺寸获取视图截屏（一屏无法显示完整）,适用于UIScrollView UITableviewView UICollectionView UIWebView
 *
 *  @return UIImage 截取的图片
 */
- (UIImage *)webViewCutter
{
    //保存
    CGPoint savedContentOffset = self.scrollView.contentOffset;
    CGRect savedFrame = self.frame;
    
    self.scrollView.contentOffset = CGPointZero;
    self.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    
    UIImage *image = [self viewCutter];
    
    //还原数据
    self.scrollView.contentOffset = savedContentOffset;
    self.frame = savedFrame;
    
    return image;
}
@end
