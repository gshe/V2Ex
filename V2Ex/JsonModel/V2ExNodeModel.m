//
//  V2ExNodeModel.m
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExNodeModel.h"

@implementation V2ExNodeModel
+ (JSONKeyMapper *)keyMapper {
	return [[JSONKeyMapper alloc] initWithDictionary:@{
													   @"id" : @"_id",
													   }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
	return YES;
}
@end
