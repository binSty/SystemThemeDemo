//
//  GBYNavigationView.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#import "GBYNavigationView.h"
#import "UIColor+Dark.h"

@implementation GBYNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self navigationViewControlInit];
    }
    return self;
}

- (void)navigationViewControlInit {
    self.navigationBackView = [[UIView alloc] init];
    [self addSubview:self.navigationBackView];
    self.navigationBackView.lee_theme
    .leeAddBackgroundColor(DAY, UIRGBColor(255, 255, 255))
    .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
    
    self.navigationBackButton = [GBYTouchPointButton buttonWithType:UIButtonTypeCustom];
    [self.navigationBackButton addTarget:self action:@selector(navigationBackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBackButton.lee_theme
    .LeeAddButtonImage(DAY, [UIImage imageNamed:@"navBackBtnBlack"], UIControlStateNormal)
    .LeeAddButtonImage(NIGHT, [UIImage imageNamed:@"navBackBtnWhite"], UIControlStateNormal);
    self.navigationBackButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.navigationBackButton.imageView.clipsToBounds = YES;
    [self addSubview:self.navigationBackButton];
    
    self.navigationTitleLabel = [[UILabel alloc] init];
    self.navigationTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationTitleLabel.font = UIDEFAULTFONTSIZE(17);
    self.navigationTitleLabel.lee_theme
    .LeeAddTextColor(DAY, [UIColor blackColor])
    .LeeAddTextColor(NIGHT, [UIColor whiteColor]);
    [self addSubview:self.navigationTitleLabel];
    
    self.navigationLineView = [[UIView alloc] init];
    self.navigationLineView.lee_theme
    .leeAddBackgroundColor(DAY, UIColorFromRGB(0xf5f5f5))
    .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
    [self addSubview:self.navigationLineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.navigationBackView.frame = self.bounds;
    self.navigationBackButton.frame = CGRectMake(6*kXX, kStatusBarHeight + (kNavigationBarHeight - kStatusBarHeight - 29*kYY)/2, 29*kYY, 29*kYY);
    self.navigationTitleLabel.frame = CGRectMake(70*kXX, kStatusBarHeight + (kNavigationBarHeight - kStatusBarHeight - 30*kYY)/2, kScreenW - 140*kXX, 30*kYY);
    self.navigationLineView.frame = CGRectMake(0, kNavigationBarHeight - 1*kYY, kScreenW, 1*kYY);
}

- (void)navigationBackButtonClick:(UIButton *)sender {
    if (self.navigationBackButtonClickBlock) {
        self.navigationBackButtonClickBlock();
    }
}

@end
