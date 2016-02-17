//
//  V2ExMember.m
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExMemberModel.h"

@implementation V2ExMemberModel
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"id" : @"_id",
  }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}

- (BOOL)isFound {
  return [self.status isEqualToString:@"found"];
}
@end
