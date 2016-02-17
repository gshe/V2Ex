//
//  XMDeveloperHelper.h
//  xmLife
//
//  Created by LeeHu on 6/4/15.
//  Copyright (c) 2015 PaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMDeveloperHelper : NSObject

#if DEBUG

+ (instancetype)sharedInstance;

- (BOOL)isDeveloper;

- (void)openFlex;
- (void)closeFlex;
- (BOOL)isFlexOpen;
#endif


@end
