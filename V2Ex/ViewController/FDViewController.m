//
//  FDViewController.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDViewController.h"

@implementation FDViewController

- (void)viewDidLoad {
  [super viewDidLoad];
	//_tabBarInitStatus = self.rdv_tabBarController.tabBarHidden;
  self.view.backgroundColor = [UIColor whiteColor];
  self.edgesForExtendedLayout = UIRectEdgeNone;
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
