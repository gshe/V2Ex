//
//  V2ExNodesViewController.m
//  Floyd
//
//  Created by George She on 16/2/2.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExNodesViewController.h"
#import "V2ExNodeModel.h"
#import "V2ExNodesCell.h"

@interface V2ExNodesViewController () <V2ExNodesCellDelegate>
@property(nonatomic, strong) NSString *myNodeListPath;
@property(nonatomic, strong) NSArray *headerTitleArray;
@property(nonatomic, strong) NSArray *nodesArray;

@property(nonatomic, strong) NSArray *myNodesArray;
@property(nonatomic, strong) NSArray *otherNodesArray;
@end

@implementation V2ExNodesViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.headerTitleArray = @[
    @"我的节点",
    @"分享与探索",
    @"V2EX",
    @"iOS",
    @"Geek",
    @"游戏",
    @"Apple",
    @"生活",
    @"Internet",
    @"城市",
    @"品牌"
  ];

  self.myNodeListPath = [NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  self.myNodeListPath =
      [self.myNodeListPath stringByAppendingString:@"/nodes.plist"];

  self.myNodesArray = [NSArray arrayWithContentsOfFile:self.myNodeListPath];
  if (!self.myNodesArray) {
    self.myNodesArray = [NSArray array];
  }

  self.otherNodesArray =
      [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                           pathForResource:@"NodesList"
                                                    ofType:@"plist"]];

  [self loadData];
}

- (void)loadData {
  NSMutableArray *nodesArray =
      [NSMutableArray arrayWithObject:self.myNodesArray];
  ;
  [nodesArray addObjectsFromArray:self.otherNodesArray];

  self.nodesArray = [self itemsWithDictArray:nodesArray];
  NSMutableArray *contents = [@[] mutableCopy];
  for (NSInteger index = 0; index < self.headerTitleArray.count; index++) {
    [contents addObject:self.headerTitleArray[index]];
    V2ExNodesCellUserData *userData = [[V2ExNodesCellUserData alloc] init];
    userData.nodeArr = self.nodesArray[index];
    userData.delegate = self;
    [contents
        addObject:[[NICellObject alloc] initWithCellClass:[V2ExNodesCell class]
                                                 userInfo:userData]];
  }
  [self setTableData:contents];
}

- (NSArray *)itemsWithDictArray:(NSArray *)nodesArray {

  NSMutableArray *items = [NSMutableArray new];

  for (NSArray *sectionDictList in nodesArray) {
    NSMutableArray *setionItems = [NSMutableArray new];
    for (NSDictionary *dataDict in sectionDictList) {
      NSString *nodeTitle = dataDict[@"name"];
      NSString *nodeName = dataDict[@"title"];

      V2ExNodeModel *model = [[V2ExNodeModel alloc] init];
      model.title = nodeTitle;
      model.name = nodeName;

      [setionItems addObject:model];
    }
    [items addObject:setionItems];
  }

  return items;
}

#pragma V2ExNodesCellDelegate
- (void)nodeSelected:(V2ExNodeModel *)node {
  if ([self.delegate
          respondsToSelector:@selector(nodeSelectFromNodesViewController:)]) {
    [self.delegate nodeSelectFromNodesViewController:node];
  }
  [self.navigationController popViewControllerAnimated:YES];
}
@end
