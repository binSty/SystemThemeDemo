//
//  UserDefaultManage.h
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaultManage : NSObject

/** 跟随系统 */
BOOL systemSwitchState(void);
void setSystemSwitchState(BOOL systemState);

/** 亮色模式 */
BOOL lightThemeState(void);
void setLightThemeState(BOOL themeState);

/** 深色模式 */
BOOL darkThemeState(void);
void setDarkThemeState(BOOL themeState);

@end

NS_ASSUME_NONNULL_END
