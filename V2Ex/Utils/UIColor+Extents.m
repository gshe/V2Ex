//
//  UIColor+HexRGB.m
//
//
//  Created by Chen.Cui on 13-8-14.
//  Copyright (c) 2013年 Michael. All rights reserved.
//

#import "UIColor+Extents.h"

@implementation UIColor (HexRGB)

+ (UIColor *)ex_mainTextColor
{
    return [UIColor ex_colorFromHexRGB:@"414141"];
}

+ (UIColor *)ex_subTextColor
{
    return [UIColor ex_colorFromHexRGB:@"909090"];
}

+ (UIColor *)ex_noteTextColor
{
    return [UIColor ex_colorFromHexRGB:@"c0c0c0"];
}

+ (UIColor *)ex_greenTextColor
{
    return [UIColor ex_colorFromHexRGB:@"5ca954"];
}

+ (UIColor *)ex_blueTextColor
{
    return [UIColor ex_colorFromHexRGB:@"25add4"];
}

+ (UIColor *)ex_orangeTextColor
{
    return [UIColor ex_colorFromHexRGB:@"ff7800"];
}

+ (UIColor *)ex_purpleTextColor
{
    return [UIColor ex_colorFromHexRGB:@"9874ff"];
}

+ (UIColor *)ex_globalBackgroundColor
{
    return [UIColor ex_colorFromHexRGB:@"f5f5f5"];
}

+ (UIColor *)ex_separatorLineColor
{
    return [UIColor ex_colorFromHexRGB:@"f1f1f1"];
}

+ (UIColor *)ex_badgeFillColor
{
    return [UIColor ex_colorFromHexRGB:@"ff5601"];
}

+ (UIColor *)ex_randomColor
{
    CGFloat red = (arc4random() % 256) / 256.0;
    CGFloat green = (arc4random() % 256) / 256.0;
    CGFloat blue = (arc4random() % 256) / 256.0;

    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)ex_colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;

    if (nil != inColorString) {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void)[scanner scanHexInt:&colorCode];
    }
    redByte = (unsigned char)(colorCode >> 16);
    greenByte = (unsigned char)(colorCode >> 8);
    blueByte = (unsigned char)(colorCode);
    result = [UIColor colorWithRed:(CGFloat)redByte / 0xff
                             green:(CGFloat)greenByte / 0xff
                              blue:(CGFloat)blueByte / 0xff
                             alpha:1.0];
    return result;
}
/***
 **UIColor之16进制数颜色值转换 RGB颜色值
 **比如：#FF6703、0XFF9900 等颜色字符串：
 **/
+ (UIColor *)ex_colorWithHexString:(NSString *)stringToConvert
{
    return [UIColor ex_colorWithHexString:stringToConvert alpha:1.0];
}

+ (UIColor *)ex_colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha
{

    NSString *cString =
        [[stringToConvert stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6)
        return [UIColor clearColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];

    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((CGFloat)r / 0xff)
                           green:((CGFloat)g / 0xff)
                            blue:((CGFloat)b / 0xff)
                           alpha:alpha];
}

+ (UIColor *)ex_colorFromInt:(NSInteger)intValue
{
    int r = (intValue & (0xff << 16)) >> 16;
    int g = (intValue & (0xff << 8)) >> 8;
    int b = intValue & (0xff);

    //PTLogDebug(@"r = %d g = %d, b = %d", r, g, b);
    UIColor *rgb = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
    return rgb;
}

- (BOOL)ex_isEqualToColor:(UIColor *)color
{
    return CGColorEqualToColor(self.CGColor, color.CGColor);
}

@end
