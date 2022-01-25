//
//  AppDelegate.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#import "AppDelegate.h"
#import "GBYTabBarController.h"
#import "ThemeColorManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self themeConfig];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    GBYTabBarController *tabBarController = [[GBYTabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)themeConfig {
    if (darkThemeState()) {
        [ThemeColorManager defaultTheme:NIGHT];
    } else {
        [ThemeColorManager defaultTheme:DAY];
    }
}

@end
