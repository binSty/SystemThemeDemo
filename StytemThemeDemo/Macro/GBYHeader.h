//
//  GBYHeader.h
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#ifndef GBYHeader_h
#define GBYHeader_h

#define UserDefaults [NSUserDefaults standardUserDefaults]

#define DAY         @"day"
#define NIGHT       @"night"

/** 屏幕尺寸相关适配 */
#define kScreenW        [UIScreen mainScreen].bounds.size.width // 屏幕宽
#define kScreenH        [UIScreen mainScreen].bounds.size.height // 屏幕高
#define kXX             [UIScreen mainScreen].bounds.size.width / 375 // 以宽375屏幕适配机型
#define kYY             [UIScreen mainScreen].bounds.size.height / (kDevice_Is_iPhoneX ? 812 : 667) // iPhone X以下以 667 高适配，以上以 812 高适配
#define kLineHeight     (1 * KYY)   // 常用线高

/** 字体大小及粗体和常规体 */
#define UIDEFAULTFONTSIZE(__VA_ARGS__)  ([UIFont fontWithName:@"PingFang-SC-Regular" size:YD_ScaleFont(__VA_ARGS__)])
#define UIMEDIUMTFONTSIZE(__VA_ARGS__)  ([UIFont fontWithName:@"PingFang-SC-Medium" size:YD_ScaleFont(__VA_ARGS__)])
/** 字体比例 */
#define YD_ScaleFont(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375.f)*(__VA_ARGS__)

/*! 颜色大小定义 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFraomAlphaRGB(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/** 机型视频 是否iPhone X以上*/
#define kDevice_Is_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define kStatusBarHeight (kDevice_Is_iPhoneX ? 44.f : 20.f)
#define kNavigationBarHeight (kDevice_Is_iPhoneX ? 88.f : 64.f)
#define kTabbarHeight        (kDevice_Is_iPhoneX ? 83.f : 49.f)
#define kSafeBottomMagin  (kDevice_Is_iPhoneX ? 34.f : 0.f)

/// weakSelf
#define kWeakSelf __weak typeof(self) weakSelf = self;

/** weakify */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

/** strongify */
#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#endif /* GBYHeader_h */
