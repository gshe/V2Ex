//
//  FDTableViewController.m
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewController.h"

@interface FDTableViewController () <NIMutableTableViewModelDelegate>

@end

@implementation FDTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)setTableData:(NSArray *)tableCells {
  NIDASSERT([NSThread isMainThread]);

  self.model =
      [[NIMutableTableViewModel alloc] initWithSectionedArray:tableCells
                                                     delegate:self];

  self.tableView.dataSource = _model;
  [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)aTableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [NICellFactory tableView:aTableView
          heightForRowAtIndexPath:indexPath
                            model:(NITableViewModel *)aTableView.dataSource];
}

#pragma mark - NIMutableTableViewModelDelegate

- (UITableViewCell *)tableViewModel:(NITableViewModel *)tableViewModel
                   cellForTableView:(UITableView *)tableView
                        atIndexPath:(NSIndexPath *)indexPath
                         withObject:(id)object {
  return [NICellFactory tableViewModel:tableViewModel
                      cellForTableView:tableView
                           atIndexPath:indexPath
                            withObject:object];
}

#pragma Action
- (void)showError:(NSError *)error {
  if (error) {
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"错误"
                  message:[NSString stringWithFormat:@"%@", error]
                 delegate:nil
        cancelButtonTitle:@"确定"
        otherButtonTitles:nil, nil];
    [alert show];
  }
}

#pragma MBProgressHUD
- (void)showHUD {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideAllHUDs {
  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
@end
