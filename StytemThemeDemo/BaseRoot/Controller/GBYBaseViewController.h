//
//  GBYBaseViewController.h
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#import <UIKit/UIKit.h>
#import "GBYNavigationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GBYBaseViewController : UIViewController

/// 自定义导航栏view 隐藏了系统导航栏
@property (nonatomic, strong) GBYNavigationView *navigationView;

@end

NS_ASSUME_NONNULL_END
