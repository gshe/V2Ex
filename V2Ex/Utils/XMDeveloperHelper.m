//
//  XMDeveloperHelper.m
//  xmLife
//
//  Created by LeeHu on 6/4/15.
//  Copyright (c) 2015 PaiTao. All rights reserved.
//

#import "XMDeveloperHelper.h"
#import "FLEXManager.h"

@implementation XMDeveloperHelper

#if DEBUG
+ (instancetype)sharedInstance {
  static dispatch_once_t once;
  static id __singleton__ = nil;
  dispatch_once(&once, ^{
    __singleton__ = [[XMDeveloperHelper alloc] init];
  });
  return __singleton__;
}

- (instancetype)init {
  if ((self = [super init])) {
    [[FLEXManager sharedManager] simulatorShortcutsEnabled];
  }

  return self;
}

- (BOOL)isDeveloper {
  return NO;
}

- (void)openFlex {
  [[FLEXManager sharedManager] showExplorer];
}

- (void)closeFlex {
  [[FLEXManager sharedManager] hideExplorer];
}

- (BOOL)isFlexOpen {
  return ![[FLEXManager sharedManager] isHidden];
}

#endif

@end
