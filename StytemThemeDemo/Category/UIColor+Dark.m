//
//  UIColor+Dark.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#import "UIColor+Dark.h"

@implementation UIColor (Dark)

/// 导航栏背景色
+ (UIColor *)navigationBackgroundColor {
    /// 只有iOS13才需要处理深色模式，设置里面设置了本地状态的值，就肯定大于iOS13系统
    if (systemSwitchState()) {
        if (@available(iOS 13.0, *)) {
            return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return [UIColor blackColor];
                } else {
                    return [UIColor whiteColor];
                }
            }];
        }
    }
    return [UIColor whiteColor];
}

/// 导航栏标题字体颜色
+ (UIColor *)navigationTitleBackgroundColor {
    if (systemSwitchState()) {
        if (@available(iOS 13.0, *)) {
            return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return [UIColor whiteColor];
                } else {
                    return [UIColor blackColor];
                }
            }];
        }
    }
    return [UIColor blackColor];
}

/// 导航栏分割线背景色
+ (UIColor *)navigationLineViewBackgroundColor {
    if (systemSwitchState()) {
        if (@available(iOS 13.0, *)) {
            return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return [UIColor blackColor];
                } else {
                    return UIColorFromRGB(0xF5F5F5);
                }
            }];
        }
    }
    return UIColorFromRGB(0xF5F5F5);
}

/// tabBar背景色
+ (UIColor *)tabBarBackgroundColor {
    if (systemSwitchState()) {
        if (@available(iOS 13.0, *)) {
            return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return [UIColor blackColor];
                } else {
                    return UIColorFromRGB(0xF5F5F5);
                }
            }];
        }
    }
    return UIColorFromRGB(0xF5F5F5);
}

+ (UIColor *)tabbarShadowImageColor {
    if (systemSwitchState()) {
        if (@available(iOS 13.0, *)) {
            return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return [UIColor blackColor];
                } else {
                    return UIColorFromRGB(0xEEEEEE);
                }
            }];
        }
    }
    return UIColorFromRGB(0xEEEEEE);
}

/// controller背景色
+ (UIColor *)viewControllerBackgroundColor {
    if (systemSwitchState()) {
        if (@available(iOS 13.0, *)) {
            return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return [UIColor blackColor];
                } else {
                    return [UIColor whiteColor];
                }
            }];
        }
    }
    return [UIColor whiteColor];
}

@end
