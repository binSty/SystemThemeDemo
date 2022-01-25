//
//  UIColor+Dark.h
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Dark)

/// 导航栏背景色
+ (UIColor *)navigationBackgroundColor;

/// 导航栏标题字体颜色
+ (UIColor *)navigationTitleBackgroundColor;

/// 导航栏分割线背景色
+ (UIColor *)navigationLineViewBackgroundColor;

/// tabBar背景色
+ (UIColor *)tabBarBackgroundColor;

/// tabbar顶部阴影背景色
+ (UIColor *)tabbarShadowImageColor;

/// controller背景色
+ (UIColor *)viewControllerBackgroundColor;

@end

NS_ASSUME_NONNULL_END
