//
//  V2ExTopicCell.h
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
#import "V2ExTopicModel.h"

@interface V2ExTopicCellUserData : NSObject
@property(nonatomic, strong) V2ExTopicModel *topic;
@end

@interface V2ExTopicCell : FDTableViewCell
@property(nonatomic, strong) V2ExTopicCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
