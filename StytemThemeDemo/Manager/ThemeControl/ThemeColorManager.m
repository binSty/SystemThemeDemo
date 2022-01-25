//
//  ThemeColorManager.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/25.
//

#import "ThemeColorManager.h"

@interface ThemeColorManager ()

@property (nonatomic, copy) NSString *defaultTag;

@property (nonatomic, copy) NSString *currentTag;

@end

@implementation ThemeColorManager

+ (instancetype)sharedInstance {
    static ThemeColorManager *colorManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colorManager = [[ThemeColorManager alloc] init];
    });
    return colorManager;
}

#pragma mark --
#pragma mark -- Public Method
+ (void)startTheme:(NSString *)tag {
    if (!tag) return;
    [ThemeColorManager sharedInstance].currentTag = tag;
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeChangingNotificaiton object:nil userInfo:nil];
}

+ (void)defaultTheme:(NSString *)tag {
    if (!tag) return;
    [ThemeColorManager sharedInstance].defaultTag = tag;
    if (![ThemeColorManager sharedInstance].currentTag) {
        [ThemeColorManager sharedInstance].currentTag = tag;
    }
}

+ (NSString *)currentThemeTag {
    return [ThemeColorManager sharedInstance].currentTag;
}

@end
