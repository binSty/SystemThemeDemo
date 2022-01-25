//
//  GBYMineSettingThemeTableViewCell.h
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GBYMineSettingThemeTableViewCellStyle) {
    GBYMineSettingThemeTableViewCellStyleDefault,
    GBYMineSettingThemeTableViewCellStyleSwitch,
    GBYMineSettingThemeTableViewCellStyleSelectImage
};

typedef void(^GBYSwitchSelectStateBlock)(BOOL switchState);

@interface GBYMineSettingThemeTableViewCell : UITableViewCell

@property (nonatomic, assign) GBYMineSettingThemeTableViewCellStyle cellStyle;

@property (nonatomic, copy) GBYSwitchSelectStateBlock switchSelectStateBlock;

@property (nonatomic, strong) UISwitch *cellSwitch;

@property (nonatomic, strong) UIImageView *selectThemeImage;

@end

NS_ASSUME_NONNULL_END
