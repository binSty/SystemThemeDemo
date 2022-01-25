//
//  UIImage+ColorImage.h
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ColorImage)

/// 颜色转UIImage
/// @param color 颜色转图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
