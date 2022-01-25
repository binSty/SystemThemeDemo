//
//  GBYTouchPointButton.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#import "GBYTouchPointButton.h"

@implementation GBYTouchPointButton

/// 当前按钮点击区域小于默认 44*44 时
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(44 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
