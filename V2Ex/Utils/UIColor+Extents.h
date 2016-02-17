//
//  UIColor+HexRGB.h
//
//
//  Created by Chen.Cui on 13-8-14.
//  Copyright (c) 2013年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexRGB)

+ (UIColor *)ex_mainTextColor; //主文本色

+ (UIColor *)ex_subTextColor; //辅助文本色

+ (UIColor *)ex_noteTextColor; //提示文本

+ (UIColor *)ex_greenTextColor; //绿文本色

+ (UIColor *)ex_blueTextColor; //蓝文本色

+ (UIColor *)ex_orangeTextColor; //橙文本色

+ (UIColor *)ex_purpleTextColor; //紫文本色

+ (UIColor *)ex_globalBackgroundColor; //全局背景色

+ (UIColor *)ex_separatorLineColor; //分割线颜色

+ (UIColor *)ex_randomColor; //随机色

+ (UIColor *)ex_badgeFillColor; //点 填充颜色

+ (UIColor *)ex_colorFromHexRGB:(NSString *)inColorString;
+ (UIColor *)ex_colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)ex_colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;
+ (UIColor *)ex_colorFromInt:(NSInteger)intValue;
- (BOOL)ex_isEqualToColor:(UIColor *)color;

@end
