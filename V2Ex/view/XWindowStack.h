//
//  XWindowStack.h
//  MeijiasongTest
//
//  Created by xiaodao on 14-7-2.
//  Copyright (c) 2014年 xiaodao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWindowStack : NSObject

+ (instancetype)sharedInstance;

+ (UIWindow *)createWindow;

+ (UIWindow *)createWindowWithRootVC:(UIViewController *)rootVC;

+ (void)pushWindowWithRootVC:(UIViewController *)rootVC;

+ (void)pushWindow:(UIWindow *)window;

+ (void)popWindow;
+ (void)popToRootWindow;

+ (UIWindow *)topWindow;
+ (UIWindow *)rootWindow;

+ (NSInteger)count;

@end
