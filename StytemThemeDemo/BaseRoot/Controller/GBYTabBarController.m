//
//  GBYTabBarController.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#import "GBYTabBarController.h"
#import "GBYNavigationController.h"
#import "UIImage+ColorImage.h"
#import "ThemeColorManager.h"

@interface GBYTabBarController ()

@end

@implementation GBYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTabBar];
    [self setTabBarInit];
}

- (void)initTabBar {
    if (@available(iOS 15.0, *)) {
        
        NSDictionary* normalTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                              UIColorFromRGB(0xA0A0A0),
                                            NSForegroundColorAttributeName,
                                            UIDEFAULTFONTSIZE(10),
                                            NSFontAttributeName,
                                            nil];
        NSDictionary *selectTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                            UIColorFromRGB(0X308014),
                                            NSForegroundColorAttributeName,
                                            UIDEFAULTFONTSIZE(10),
                                            NSFontAttributeName,
                                            nil];
        UITabBarAppearance *barAppearance = [[UITabBarAppearance alloc] init];
        @weakify(self);
        self.lee_theme
        .LeeThemeChangingBlock(^(NSString * _Nonnull tag, id  _Nonnull item) {
            @strongify(self);
            if ([[ThemeColorManager currentThemeTag] isEqualToString:DAY]) {
                barAppearance.backgroundColor = UIColorFromRGB(0xf5f5f5);
            } else {
                barAppearance.backgroundColor = UIRGBColor(40, 40, 40);
            }
            self.tabBar.scrollEdgeAppearance = barAppearance;
            self.tabBar.standardAppearance = barAppearance; // 与nav同理
        });
//        barAppearance.lee_theme
//        .leeAddBackgroundColor(DAY, UIColorFromRGB(0xf5f5f5))
//        .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
//        barAppearance.backgroundColor = [UIColor tabBarBackgroundColor];
//        barAppearance.shadowImage = [UIImage imageWithColor:[UIColor tabbarShadowImageColor]];
        // 如果是隐藏系统导航栏，自定义导航栏的话，initTabBar方法中设置选中字体颜色在 iOS15同样生效，若用了系统导航栏，iOS15则需要如下方法设置tabBar字体颜色
        barAppearance.stackedLayoutAppearance.normal.titleTextAttributes = normalTextAttributes;
        barAppearance.stackedLayoutAppearance.selected.titleTextAttributes = selectTextAttributes;
        self.tabBar.scrollEdgeAppearance = barAppearance;
        self.tabBar.standardAppearance = barAppearance; // 与nav同理
    } else {
        self.tabBar.lee_theme
        .LeeAddShadowImage(DAY, [UIImage imageWithColor:UIColorFromRGB(0xeeeeee)])
        .LeeAddImage(NIGHT, [UIImage imageWithColor:UIRGBColor(40, 40, 40)]);
        
        self.tabBar.lee_theme
        .LeeAddBarTintColor(DAY , UIColorFromRGB(0xF5F5F5))
        .LeeAddBarTintColor(NIGHT , UIRGBColor(40, 40, 40));
        [UITabBar appearance].translucent = NO;// 这句表示取消tabBar的透明效果。
    }
}

- (void)setTabBarInit {
    NSArray<NSDictionary *> *childArray = @[
                            @{ @"ControllKey": @"GBYHomeViewController",
                               @"TitleKey": @"首页",
                               @"NormalImageKey": @"tabbar_home",
                               @"SelectImageKey": @"tabbar_homeHL" },
                            @{ @"ControllKey": @"GBYMineViewController",
                               @"TitleKey": @"我的",
                               @"NormalImageKey": @"tabbar_mine",
                               @"SelectImageKey": @"tabbar_mineHL" },
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *classVC = [NSClassFromString(obj[@"ControllKey"]) new];
        classVC.navigationItem.title = obj[@"TitleKey"];
        GBYNavigationController *navVC = [[GBYNavigationController alloc] initWithRootViewController:classVC];

        navVC.tabBarItem.title = obj[@"TitleKey"];
        navVC.tabBarItem.image = [UIImage imageNamed:obj[@"NormalImageKey"]];
        navVC.tabBarItem.selectedImage = [UIImage imageNamed:obj[@"SelectImageKey"]];
        navVC.tabBarItem.selectedImage = [navVC.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        NSDictionary* normalTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                              UIColorFromRGB(0xA0A0A0),
                                            NSForegroundColorAttributeName,
                                            UIDEFAULTFONTSIZE(10),
                                            NSFontAttributeName,
                                            nil];
        NSDictionary *selectTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                            UIColorFromRGB(0X308014),
                                            NSForegroundColorAttributeName,
                                            UIDEFAULTFONTSIZE(10),
                                            NSFontAttributeName,
                                            nil];
        [navVC.tabBarItem setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
        [navVC.tabBarItem setTitleTextAttributes:selectTextAttributes forState:UIControlStateSelected];
        // 调整字体和图片间距
        navVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
        navVC.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
        [self addChildViewController:navVC];
    }];
}

@end
