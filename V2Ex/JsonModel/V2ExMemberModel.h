//
//  V2ExMember.h
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol V2ExMemberModel
@end

@interface V2ExMemberModel : JSONModel
@property(nonatomic) long _id;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *tagline;
@property(nonatomic, strong) NSString *avatar_mini;
@property(nonatomic, strong) NSString *avatar_normal;
@property(nonatomic, strong) NSString *avatar_large;

@property(nonatomic, copy) NSString *bio;
@property(nonatomic, copy) NSString *created;
@property(nonatomic, copy) NSString *location;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *twitter;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *website;
@property(nonatomic, copy) NSString *github;
@property(nonatomic, copy) NSString *psn;
@property(nonatomic, assign, readonly) BOOL isFound;
@end
