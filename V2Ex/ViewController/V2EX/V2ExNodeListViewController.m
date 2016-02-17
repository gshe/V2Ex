//
//  V2ExNodeListViewController.m
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExNodeListViewController.h"
#import "V2ExNodeCell.h"

@interface V2ExNodeListViewController ()
@property(nonatomic, strong) NSMutableArray<V2ExNodeModel> *nodeArray;
@end

@implementation V2ExNodeListViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"节点";
  [self refreshUI];
}

- (void)refreshUI {
  self.nodeArray = [@[] mutableCopy];
  V2ExNodeModel *node = [[V2ExNodeModel alloc] init];
  node.name = @"latest";
  node.title = @"最新";
  [self.nodeArray addObject:node];

  node = [[V2ExNodeModel alloc] init];
  node.name = @"hot";
  node.title = @"热门";
  [self.nodeArray addObject:node];
  NSMutableArray *contents = [@[] mutableCopy];
  for (V2ExNodeModel *item in self.nodeArray) {
    V2ExNodeCellUserData *userData = [[V2ExNodeCellUserData alloc] init];
    userData.node = item;
    [contents
        addObject:[[NICellObject alloc] initWithCellClass:[V2ExNodeCell class]
                                                 userInfo:userData]];
  }
  [self setTableData:contents];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  if ([cell isKindOfClass:[V2ExNodeCell class]]) {
    V2ExNodeCell *nodeCell = (V2ExNodeCell *)cell;
    V2ExNodeCellUserData *userData = nodeCell.userData;
    if ([self.delegate respondsToSelector:@selector(nodeChanged:)]) {
      [self.delegate nodeChanged:userData.node];
    }
  }
}
@end
