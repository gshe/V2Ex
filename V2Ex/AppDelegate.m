//
//  AppDelegate.m
//  V2Ex
//
//  Created by George She on 16/2/17.
//  Copyright © 2016年 Freedom. All rights reserved.
//

#import "AppDelegate.h"
#import "V2ExNodeListViewController.h"
#import "V2ExTopicListViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
- (UIViewController *)getRootViewController {
  V2ExNodeListViewController *rightVC =
      [[V2ExNodeListViewController alloc] initWithNibName:nil bundle:nil];
  V2ExTopicListViewController *mainVC =
      [[V2ExTopicListViewController alloc] initWithNibName:nil bundle:nil];
  MyV2ExProfileViewController *leftVC =
      [[MyV2ExProfileViewController alloc] initWithNibName:nil bundle:nil];
  UINavigationController *mainNavi =
      [[UINavigationController alloc] initWithRootViewController:mainVC];
  UINavigationController *rightNavi =
      [[UINavigationController alloc] initWithRootViewController:rightVC];
  rightVC.delegate = mainVC;
  leftVC.delegate = mainVC;
  MMDrawerController *v2ExController =
      [[MMDrawerController alloc] initWithCenterViewController:mainNavi
                                      leftDrawerViewController:leftVC
                                     rightDrawerViewController:rightNavi];
  [v2ExController setShowsShadow:NO];
  [v2ExController setRestorationIdentifier:@"MMDrawer3"];
  [v2ExController setMaximumLeftDrawerWidth:150];
  [v2ExController setMaximumRightDrawerWidth:150];
  [v2ExController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
  [v2ExController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
  [v2ExController
      setDrawerVisualStateBlock:^(MMDrawerController *drawerController,
                                  MMDrawerSide drawerSide,
                                  CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
            drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
          block(drawerController, drawerSide, percentVisible);
        }
      }];
  return v2ExController;
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  [[UINavigationBar appearance]
      setBackgroundColor:[UIColor colorWithRed:236 / 255.0
                                         green:190 / 255.0
                                          blue:146 / 255.0
                                         alpha:0.9]];
  UIViewController *rootVC = [self getRootViewController];
  self.window.rootViewController = rootVC;
  [self.window makeKeyAndVisible];
  [XWindowStack pushWindow:self.window];
  [NSThread sleepForTimeInterval:1];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state.
  // This can occur for certain types of temporary interruptions (such as an
  // incoming phone call or SMS message) or when the user quits the application
  // and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down
  // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate
  // timers, and store enough application state information to restore your
  // application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called
  // instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state;
  // here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the
  // application was inactive. If the application was previously in the
  // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if
  // appropriate. See also applicationDidEnterBackground:.
}

@end
