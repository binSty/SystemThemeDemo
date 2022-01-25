//
//  UserDefaultManage.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/21.
//

#import "UserDefaultManage.h"

static NSString *const syetemSwitchStateConst = @"syetemSwitchStateConst";
static NSString *const lightThemeStateConst = @"lightThemeStateConst";
static NSString *const darkThemeStateConst = @"darkThemeStateConst";

@implementation UserDefaultManage

/** 跟随系统 */
BOOL systemSwitchState(void) {
    BOOL isUpdate = [UserDefaults boolForKey:syetemSwitchStateConst];
    return isUpdate;
}
void setSystemSwitchState(BOOL systemState) {
    [UserDefaults setBool:systemState forKey:syetemSwitchStateConst];
    [UserDefaults synchronize];
}

/** 亮色模式 */
BOOL lightThemeState(void) {
    BOOL isUpdate = [UserDefaults boolForKey:lightThemeStateConst];
    return isUpdate;
}
void setLightThemeState(BOOL themeState) {
    [UserDefaults setBool:themeState forKey:lightThemeStateConst];
    [UserDefaults synchronize];
}

/** 深色模式 */
BOOL darkThemeState(void) {
    BOOL isUpdate = [UserDefaults boolForKey:darkThemeStateConst];
    return isUpdate;
}
void setDarkThemeState(BOOL themeState) {
    [UserDefaults setBool:themeState forKey:darkThemeStateConst];
    [UserDefaults synchronize];
}

@end
