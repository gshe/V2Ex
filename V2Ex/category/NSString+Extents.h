//
//  NSString+Extents.h
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extents)
- (CGFloat)lineBreakSizeOfStringwithFont:(UIFont *)font
                                maxwidth:(CGFloat)width
                           lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)lineBreakSizeExOfStringwithFont:(UIFont *)font
                                 maxwidth:(CGFloat)width
                            lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end
