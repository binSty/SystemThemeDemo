//
//  GBYNavigationView.h
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#import <UIKit/UIKit.h>
#import "GBYTouchPointButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface GBYNavigationView : UIView

/// 左边按钮响应
@property (nonatomic, strong) dispatch_block_t navigationBackButtonClickBlock;

/// 导航栏背景视图
@property (nonatomic, strong) UIView *navigationBackView;

/// 返回按钮
@property (nonatomic, strong) GBYTouchPointButton *navigationBackButton;

/// 导航标题
@property (nonatomic, strong) UILabel *navigationTitleLabel;

/// 导航栏底部下划线
@property (nonatomic, strong) UIView *navigationLineView;

@end

NS_ASSUME_NONNULL_END
