//
//  NSString+Extents.m
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "NSString+Extents.h"

@implementation NSString (Extents)
- (CGFloat)lineBreakSizeOfStringwithFont:(UIFont *)font
                                maxwidth:(CGFloat)width
                           lineBreakMode:(NSLineBreakMode)lineBreakMode {
  CGRect rect;
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) &&                              \
     __IPHONE_OS_VERSION_MIN_REQUIRED < 70000)
  CGSize size = [self sizeWithFont:font
                 constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                     lineBreakMode:lineBreakMode];
  rect = CGRectMake(0, 0, size.width, size.height);
#else
  NSMutableParagraphStyle *paragraphStyle =
      [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.lineBreakMode = lineBreakMode;
  rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                            options:NSStringDrawingUsesLineFragmentOrigin |
                                    NSStringDrawingUsesFontLeading
                         attributes:@{
                           NSFontAttributeName : font,
                           NSParagraphStyleAttributeName : paragraphStyle.copy
                         } context:nil];
#endif
  return ceil(rect.size.height);
}

- (CGSize)lineBreakSizeExOfStringwithFont:(UIFont *)font
                                 maxwidth:(CGFloat)width
                            lineBreakMode:(NSLineBreakMode)lineBreakMode {
  CGRect rect;
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) &&                              \
     __IPHONE_OS_VERSION_MIN_REQUIRED < 70000)
  CGSize size = [self sizeWithFont:font
                 constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                     lineBreakMode:lineBreakMode];
  rect = CGRectMake(0, 0, size.width, size.height);
#else
  NSMutableParagraphStyle *paragraphStyle =
      [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.lineBreakMode = lineBreakMode;
  rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                            options:NSStringDrawingUsesLineFragmentOrigin |
                                    NSStringDrawingUsesFontLeading
                         attributes:@{
                           NSFontAttributeName : font,
                           NSParagraphStyleAttributeName : paragraphStyle.copy
                         } context:nil];
#endif
  return rect.size;
}
@end
