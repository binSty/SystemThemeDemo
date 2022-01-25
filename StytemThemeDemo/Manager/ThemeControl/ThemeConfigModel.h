//
//  ThemeConfigModel.h
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/25.
//

#import <Foundation/Foundation.h>
#import "ThemeColorManager.h"
#import "ThemeHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThemeConfigModel : NSObject

/** 主题改变Block -> 格式: .LeeThemeChangingBlock(^(NSString *tag , id item){ code... }) */
@property (nonatomic , copy , readonly ) ConfigThemeToChangingBlock LeeThemeChangingBlock;

/** 添加背景颜色设置 -> 格式: .LeeAddBackgroundColor(@@"tag" , UIColor) */
@property (nonatomic, copy, readonly) ConfigThemeToT_Color leeAddBackgroundColor;

/** 添加图片设置 -> 格式: .LeeAddImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic, copy, readonly) ConfigThemeToT_Image LeeAddImage;

/** 添加按钮图片设置 -> 格式: .LeeAddButtonImage(@@"tag" , UIImage , UIControlStateNormal) */
@property (nonatomic , copy , readonly ) ConfigThemeToT_ImageAndState LeeAddButtonImage;

/** 添加分隔线颜色设置 -> 格式: .LeeAddSeparatorColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) ConfigThemeToT_Color LeeAddSeparatorColor;

/** 添加文本颜色设置 -> 格式: .LeeAddTextColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) ConfigThemeToT_Color LeeAddTextColor;

/** 添加颜色设置 -> 格式: .LeeAddSelectorAndColor(@@"tag" , @@selector(XXX:) , UIColor 或 @"F3F3F3") */
@property (nonatomic , copy , readonly ) ConfigThemeToT_SelectorAndColor LeeAddSelectorAndColor;

/** 添加图片设置 -> 格式: .LeeAddSelectorAndImage(@@"tag" , @@selector(XXX:) , UIImage 或 @"imageName" 或 @"imagePath") */
@property (nonatomic , copy , readonly ) ConfigThemeToT_SelectorAndImage LeeAddSelectorAndImage;

/** 添加bar渲染颜色设置 -> 格式: .LeeAddBarTintColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) ConfigThemeToT_Color LeeAddBarTintColor;

/** 添加阴影图片设置 -> 格式: .LeeAddShadowImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic , copy , readonly ) ConfigThemeToT_Image LeeAddShadowImage;

/* 基础方法设置 */
/** 添加方法设置 -> 格式: .LeeAddSelectorAndValues(@@"tag" , @@selector(XXX:XXX:) , id , id) */
@property (nonatomic , copy , readonly ) ConfigThemeToT_SelectorAndValues LeeAddSelectorAndValues;
/** 添加方法设置 -> 格式: .LeeAddSelectorAndValueArray(@@"tag" , @@selector(XXX:XXX:) , @@[id , id]) */
@property (nonatomic , copy , readonly ) ConfigThemeToT_SelectorAndValueArray LeeAddSelectorAndValueArray;

@end

@interface NSObject (ThemeConfigObject)

@property (nonatomic, strong) ThemeConfigModel *lee_theme;

@end

NS_ASSUME_NONNULL_END
