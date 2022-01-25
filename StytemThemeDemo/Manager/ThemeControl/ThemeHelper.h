//
//  ThemeHelper.h
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/25.
//

#ifndef ThemeHelper_h
#define ThemeHelper_h

@class ThemeConfigModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^ThemeChangingBlock)(NSString *tag , id item);

typedef ThemeConfigModel * _Nonnull (^ConfigThemeToT_Color)(NSString *tag , id color);

typedef ThemeConfigModel * _Nonnull (^ConfigThemeToT_Image)(NSString *tag , id image);

typedef ThemeConfigModel * _Nonnull (^ConfigThemeToT_SelectorAndColor)(NSString *tag , SEL sel , id color);

typedef ThemeConfigModel * _Nonnull (^ConfigThemeToT_SelectorAndImage)(NSString *tag , SEL sel , id image);

typedef ThemeConfigModel * _Nonnull (^ConfigThemeToT_SelectorAndValues)(NSString *tag , SEL sel , ...);

typedef ThemeConfigModel * _Nonnull (^ConfigThemeToT_SelectorAndValueArray)(NSString *tag , SEL sel , NSArray *values);

typedef ThemeConfigModel * _Nonnull (^ConfigThemeToT_ImageAndState)(NSString *tag , UIImage *image , UIControlState state);

typedef ThemeConfigModel * _Nonnull (^ConfigThemeToChangingBlock)(ThemeChangingBlock);

NS_ASSUME_NONNULL_END

#endif /* ThemeHelper_h */
