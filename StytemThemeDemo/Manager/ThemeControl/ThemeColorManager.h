//
//  ThemeColorManager.h
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


static NSString * const ThemeChangingNotificaiton = @"ThemeChangingNotificaiton";

@interface ThemeColorManager : NSObject

/**
 *  启动主题
 *
 *  @param tag 主题标签
 */
+ (void)startTheme:(NSString *)tag;

/**
 *  默认主题 (必设置 , 应用程序最少需要一个默认主题)
 *
 *
 *  @param tag 主题标签
 */
+ (void)defaultTheme:(NSString *)tag;

/**
 *  当前主题标签
 *
 *  @return 主题标签 tag
 */
+ (NSString *)currentThemeTag;


@end

NS_ASSUME_NONNULL_END
