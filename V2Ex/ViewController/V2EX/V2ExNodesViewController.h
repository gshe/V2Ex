//
//  V2ExNodesViewController.h
//  Floyd
//
//  Created by George She on 16/2/2.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewController.h"
#import "V2ExNodeModel.h"

@protocol V2ExNodesViewControllerDelegate <NSObject>
- (void)nodeSelectFromNodesViewController:(V2ExNodeModel *)node;
@end

@interface V2ExNodesViewController : FDTableViewController
@property(nonatomic, weak) id<V2ExNodesViewControllerDelegate> delegate;
@end
