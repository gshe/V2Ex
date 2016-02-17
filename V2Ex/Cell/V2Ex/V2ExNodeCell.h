//
//  V2ExNodeCell.h
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
#import "V2ExNodeModel.h"

@interface V2ExNodeCellUserData : NSObject
@property(nonatomic, strong) V2ExNodeModel *node;
@end

@interface V2ExNodeCell : FDTableViewCell
@property(nonatomic, strong) V2ExNodeCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
