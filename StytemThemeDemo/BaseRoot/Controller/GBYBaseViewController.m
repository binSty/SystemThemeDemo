//
//  GBYBaseViewController.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#import "GBYBaseViewController.h"
#import "UIColor+Dark.h"

@interface GBYBaseViewController () <UINavigationControllerDelegate>

@end

@implementation GBYBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.lee_theme
    .leeAddBackgroundColor(DAY, UIRGBColor(255, 255, 255))
    .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
    @weakify(self);
    self.lee_theme
    .LeeThemeChangingBlock(^(NSString * _Nonnull tag, id  _Nonnull item) {
        @strongify(self);
        [self setNeedsStatusBarAppearanceUpdate];
    });
    [self setBaseControllerInit];
}

/// 修改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    if ([[ThemeColorManager currentThemeTag] isEqualToString:DAY]) {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}

- (void)setBaseControllerInit {
    self.navigationView = [[GBYNavigationView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kNavigationBarHeight)];
    @weakify(self);
    self.navigationView.navigationBackButtonClickBlock = ^{
        @strongify(self);
        [self backBtnClickMethod];
    };
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationView.navigationBackButton.hidden = NO;
    }else {
        self.navigationView.navigationBackButton.hidden = YES;
    }
    [self.view addSubview:self.navigationView];
}

- (void)backBtnClickMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark -- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.navigationController.interactivePopGestureRecognizer.enabled = self.navigationController.viewControllers.count > 1 ? YES : NO;
}

@end
