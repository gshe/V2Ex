//
//  V2ExProfileCell.h
//  Floyd
//
//  Created by George She on 16/2/2.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
#import "V2ExProfileModel.h"

@interface V2ExProfileCellUserData : NSObject
@property(nonatomic, strong) V2ExProfileModel *profileItem;
@end

@interface V2ExProfileCell : FDTableViewCell
@property(nonatomic, strong) V2ExProfileCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
