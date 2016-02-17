//
//  PopupBaseView.h
//  xmLife
//
//  Created by 胡立 on 14-9-12.
//  Copyright (c) 2014年 PaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupBaseView : UIView

@property (nonatomic, strong) UIWindow *window;

- (void)addEvent;
- (void)show;
- (void)dismiss;

@end
