//
//  V2ExNodesCell.h
//  Floyd
//
//  Created by George She on 16/2/2.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
#import "V2ExNodeModel.h"

@protocol V2ExNodesCellDelegate <NSObject>
- (void)nodeSelected:(V2ExNodeModel *)node;
@end

@interface V2ExNodesCellUserData : NSObject
@property(nonatomic, strong) NSArray *nodeArr;
@property(nonatomic, weak) id<V2ExNodesCellDelegate> delegate;
@end

@interface V2ExNodesCell : FDTableViewCell
@property(nonatomic, strong) V2ExNodesCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
