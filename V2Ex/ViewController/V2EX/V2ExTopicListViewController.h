//
//  V2ExTopicListViewController.h
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewController.h"
#import "V2ExNodeListViewController.h"
#import "MyV2ExProfileViewController.h"

@interface V2ExTopicListViewController
    : FDTableViewController <V2ExNodeListViewControllerDelegate,
                             MyV2ExProfileViewControllerDelegate>

@end
