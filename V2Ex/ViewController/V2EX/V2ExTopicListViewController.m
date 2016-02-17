//
//  V2ExTopicListViewController.m
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExTopicListViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "MJRefresh.h"
#import "V2ExDataManager.h"
#import "V2ExTopicCell.h"
#import "V2ExNodeListViewController.h"
#import "MyV2ExProfileViewController.h"
#import "V2ExNodesViewController.h"
#import "V2ExLoginViewController.h"
#import "V2ExPersonalViewController.h"
#import "V2ExCheckinManager.h"
#import "FDWebViewController.h"

@interface V2ExTopicListViewController () <V2ExNodesViewControllerDelegate>
@property(nonatomic, strong) V2ExDataManager *dataManager;
@property(nonatomic, strong) NSArray<V2ExTopicModel> *topics;
@property(nonatomic, strong) V2ExNodeModel *curNode;
@property(nonatomic, assign) BOOL isHot;
@property(nonatomic, assign) BOOL isLatest;
@end

@implementation V2ExTopicListViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.isHot = YES;
  [self refreshUI];
  self.dataManager = [[V2ExDataManager alloc] init];
  self.navigationItem.leftBarButtonItem =
      [[MMDrawerBarButtonItem alloc] initWithTarget:self
                                             action:@selector(myV2ExPressed:)];

	self.navigationItem.rightBarButtonItem = [[MMDrawerBarButtonItem alloc]
											   initWithTarget:self
											   action:@selector(v2ExNodeListPressed:)];

  self.tableView.mj_header =
      [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                       refreshingAction:@selector(loadNewData)];
  [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
  if (self.curNode) {
    [self.dataManager getTopics:nil
        nodeKey:self.curNode.name
        page:1
        completedBlock:^(NSArray<V2ExTopicModel> *ret) {
          self.topics = ret;
          [self refreshUI];
          [self.tableView.mj_header endRefreshing];
        }
        failed:^(NSError *error) {
          [self.tableView.mj_header endRefreshing];
          [self showError:error];
        }];
  } else {
    if (self.isHot) {
      [self.dataManager
          getHotTopicsWithCompletedBlock:^(NSArray<V2ExTopicModel> *ret) {
            self.topics = ret;
            [self refreshUI];
            [self.tableView.mj_header endRefreshing];
          }
          failed:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
            [self showError:error];
          }];
    } else if (self.isLatest) {
      [self.dataManager
          getLatestTopicsWithCompletedBlock:^(NSArray<V2ExTopicModel> *ret) {
            self.topics = ret;
            [self refreshUI];
            [self.tableView.mj_header endRefreshing];
          }
          failed:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
            [self showError:error];
          }];
    }
  }
}

- (void)refreshUI {
  if (self.curNode) {
    self.title = self.curNode.title;
  } else {
    if (self.isHot) {
      self.title = @"热门";
    }
    if (self.isLatest) {
      self.title = @"最新";
    }
  }

  NSMutableArray *contents = [@[] mutableCopy];
  if (self.topics) {
    for (V2ExTopicModel *item in self.topics) {
      V2ExTopicCellUserData *userData = [[V2ExTopicCellUserData alloc] init];
      userData.topic = item;
      [contents addObject:[[NICellObject alloc]
                              initWithCellClass:[V2ExTopicCell class]
                                       userInfo:userData]];
    }
  }

  [self setTableData:contents];
}

- (void)setCurNode:(V2ExNodeModel *)curNode {
  _curNode = curNode;
  [self.tableView.mj_header beginRefreshing];
  [self loadNewData];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  if ([cell isKindOfClass:[V2ExTopicCell class]]) {
    V2ExTopicCell *topicCell = (V2ExTopicCell *)cell;
    V2ExTopicCellUserData *userdata = topicCell.userData;
    FDWebViewController *vc =
        [[FDWebViewController alloc] initWithNibName:nil bundle:nil];
    vc.urlString = userdata.topic.url;
    [self.navigationController pushViewController:vc animated:YES];
  }
}

#pragma V2ExNodeListViewControllerDelegate

- (void)nodeChanged:(V2ExNodeModel *)node {
  [self.mm_drawerController closeDrawerAnimated:YES
                                     completion:^(BOOL finished) {
                                       self.curNode = node;
                                     }];
}

#pragma MyV2ExProfileViewControllerDelegate
- (void)profileItemSelected:(V2ExProfileModel *)item {
  [self.mm_drawerController closeDrawerAnimated:YES
                                     completion:^(BOOL finished) {
                                       [self loadViewController:item];
                                     }];
}
- (void)doLogin {
  [self.mm_drawerController closeDrawerAnimated:YES
                                     completion:^(BOOL finished) {
                                       [self login];
                                     }];
}

- (void)loadViewController:(V2ExProfileModel *)item {
  switch (item.profileType) {
  case V2ExProfileType_Nodes: {
    V2ExNodesViewController *vc =
        [[V2ExNodesViewController alloc] initWithNibName:nil bundle:nil];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
  } break;
  case V2ExProfileType_Latest: {
    self.isLatest = YES;
    self.isHot = NO;
    self.curNode = nil;
  } break;
  case V2ExProfileType_Profile: {
    if ([V2ExCheckinManager sharedInstance].isLogin) {
      V2ExPersonalViewController *vc =
          [[V2ExPersonalViewController alloc] initWithNibName:nil bundle:nil];
      [self.navigationController pushViewController:vc animated:YES];
    } else {
      [self doLogin];
    }
  } break;
  default:
    break;
  }
}

- (void)login {
  V2ExLoginViewController *vc =
      [[V2ExLoginViewController alloc] initWithNibName:nil bundle:nil];
  [self.navigationController presentViewController:vc
                                          animated:YES
                                        completion:nil];
}

- (void)myV2ExPressed:(id)sender {
  [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft
                                    animated:YES
                                  completion:nil];
}

- (void)v2ExNodeListPressed:(id)sender {
  [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight
                                    animated:YES
                                  completion:nil];
}

- (void)closePressed:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma V2ExNodesViewControllerDelegate
- (void)nodeSelectFromNodesViewController:(V2ExNodeModel *)node {
  self.curNode = node;
}
@end
