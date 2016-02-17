//
//  MyV2ExProfileViewController.h
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewController.h"
#import "V2ExProfileModel.h"

@protocol MyV2ExProfileViewControllerDelegate <NSObject>
- (void)profileItemSelected:(V2ExProfileModel *)item;
- (void)doLogin;
@end

@interface MyV2ExProfileViewController : FDTableViewController
@property(nonatomic, weak) id<MyV2ExProfileViewControllerDelegate> delegate;
@end
