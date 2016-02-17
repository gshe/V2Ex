//
//  XWindowStack.m
//  MeijiasongTest
//
//  Created by xiaodao on 14-7-2.
//  Copyright (c) 2014年 xiaodao. All rights reserved.
//

#import "XWindowStack.h"

@interface XWindowStack ()

@property(nonatomic, strong) NSMutableArray *windows;

@end

@implementation XWindowStack

+ (instancetype)sharedInstance {
  static dispatch_once_t once;
  static id __singleton__ = nil;
  dispatch_once(&once, ^{
    __singleton__ = [[XWindowStack alloc] init];
  });
  return __singleton__;
}

- (instancetype)init {
  if ((self = [super init])) {
    self.windows = [@[] mutableCopy];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window) {
      [self.windows addObject:window];
    }
  }
  return self;
}

+ (UIWindow *)createWindow {
  UIWindow *aWindow =
      [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  return aWindow;
}

+ (UIWindow *)createWindowWithRootVC:(UIViewController *)rootVC {
  UIWindow *aWindow =
      [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  aWindow.rootViewController = rootVC;
  return aWindow;
}

+ (void)pushWindowWithRootVC:(UIViewController *)rootVC {
  UIWindow *aWindow = [self createWindowWithRootVC:rootVC];
  [self pushWindow:aWindow];
}

+ (void)pushWindow:(UIWindow *)aWindow {
  NSMutableArray *arr = [XWindowStack sharedInstance].windows;
  if ([arr containsObject:aWindow]) {
    return;
  }

  [arr addObject:aWindow];

  aWindow.windowLevel = arr.count;
  [aWindow makeKeyAndVisible];
}

+ (void)popWindow {
  NSMutableArray *arr = [XWindowStack sharedInstance].windows;
  if (arr.count <= 1) {
    return;
  }

  [arr removeLastObject];

  UIWindow *aWindow = [arr lastObject];
  [aWindow makeKeyAndVisible];
}

+ (void)popToRootWindow {
  NSMutableArray *arr = [XWindowStack sharedInstance].windows;

  while (arr.count > 1) {
    [arr removeLastObject];
  }

  UIWindow *aWindow = [arr lastObject];
  [aWindow makeKeyAndVisible];
}

+ (UIWindow *)topWindow {
  NSMutableArray *arr = [XWindowStack sharedInstance].windows;
  assert([arr count] >= 1);
  return [arr lastObject];
}

+ (UIWindow *)rootWindow {
  NSMutableArray *arr = [XWindowStack sharedInstance].windows;
  return [arr firstObject];
}

+ (NSInteger)count {
  return [XWindowStack sharedInstance].windows.count;
}

@end
