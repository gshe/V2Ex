//
//  V2ExTopicModel.m
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExTopicModel.h"

@implementation V2ExTopicModel
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"id" : @"_id",
  }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}

- (NSString *)createdStr {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  NSDate *dt = [NSDate dateWithTimeIntervalSince1970:self.created];
  return [formatter stringFromDate:dt];
}

- (NSString *)last_modifiedStr {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  NSDate *dt = [NSDate dateWithTimeIntervalSince1970:self.last_modified];
  return [formatter stringFromDate:dt];
}
@end
