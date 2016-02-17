//
//  V2ExCheckinManager.h
//  Floyd
//
//  Created by George She on 16/2/2.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "V2ExMemberModel.h"

#define kV2ExCheckInStatusChanged @"kV2ExCheckInStatusChanged"

@interface V2ExCheckinManager : NSObject
+ (instancetype)sharedInstance;
@property(nonatomic) BOOL isLogin;
@property(nonatomic, strong) NSString *userName;
@property(nonatomic, strong) V2ExMemberModel *curUser;
- (void)resetStatus;
- (void)updateStatus;
- (void)updateUserInfo;
@end
