//
//  V2ExCheckinManager.m
//  Floyd
//
//  Created by George She on 16/2/2.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExCheckinManager.h"
#import "V2ExDataManager.h"

#define V2Ex_UserName @"V2Ex_UserName"

@implementation V2ExCheckinManager
+ (instancetype)sharedInstance {
  static V2ExCheckinManager *manager;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [[V2ExCheckinManager alloc] init];
  });
  return manager;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.userName =
        [[NSUserDefaults standardUserDefaults] objectForKey:V2Ex_UserName];
    [self updateStatus];
  }
  return self;
}

- (BOOL)isLogin {
  return self.userName;
}

- (void)setUserName:(NSString *)userName {
  _userName = userName;
  if (_userName) {
    [[NSUserDefaults standardUserDefaults] setObject:_userName
                                              forKey:V2Ex_UserName];
  } else {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:V2Ex_UserName];
  }
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)resetStatus {
  self.userName = nil;
}

- (void)updateStatus {
  if (self.userName) {
    [[V2ExDataManager sharedInstance] getCheckInURLSuccess:^(NSURL *URL) {
      if ([URL.absoluteString rangeOfString:@"mission/daily/redeem"].location !=
          NSNotFound) {

      } else {
      }

    } failure:^(NSError *error){

    }];
  }
}
- (void)updateUserInfo {
  if ([V2ExCheckinManager sharedInstance].isLogin) {
    [[V2ExDataManager sharedInstance] getMemberProfileByUserId:nil
        userName:[V2ExCheckinManager sharedInstance].userName
        completedBlock:^(V2ExMemberModel *member) {
          self.curUser = member;
          [[NSNotificationCenter defaultCenter]
              postNotificationName:kV2ExCheckInStatusChanged
                            object:nil];
        }
        failed:^(NSError *error) {
          self.curUser = nil;
        }];
  }
}
@end
