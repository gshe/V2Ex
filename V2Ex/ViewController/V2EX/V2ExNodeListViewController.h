//
//  V2ExNodeListViewController.h
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewController.h"
#import "V2ExNodeModel.h"

@protocol V2ExNodeListViewControllerDelegate <NSObject>
- (void)nodeChanged:(V2ExNodeModel *)node;
@end

@interface V2ExNodeListViewController : FDTableViewController
@property(nonatomic, weak) id<V2ExNodeListViewControllerDelegate> delegate;
@end
