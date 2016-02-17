//
//  FDTableViewController.h
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTableViewController : UITableViewController
@property(nonatomic, strong) NIMutableTableViewModel *model;
@property(nonatomic, assign, readonly) BOOL tabBarInitStatus;
- (void)setTableData:(NSArray *)tableCells;

- (void)showError:(NSError *)error;
- (void)showHUD;
- (void)hideAllHUDs;
@end
