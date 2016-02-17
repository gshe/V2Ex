//
//  V2ExTopicModel.h
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "V2ExMemberModel.h"
#import "V2ExNodeModel.h"

@protocol V2ExTopicModel
@end

@interface V2ExTopicModel : JSONModel
@property(nonatomic) long _id;
@property(nonatomic) NSInteger thanks;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSString *content_rendered;
@property(nonatomic) long created;
@property(nonatomic) long last_modified;
@property(nonatomic, strong) V2ExMemberModel *member;
@property(nonatomic, strong) V2ExNodeModel *node;
@property(nonatomic, strong, readonly) NSString *createdStr;
@property(nonatomic, strong, readonly) NSString *last_modifiedStr;
@end
