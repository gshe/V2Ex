//
//  XMBirthdaySelectView.h
//  xmLife
//
//  Created by shezhiqiang on 15/12/16.
//  Copyright (c) 2015年 PaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupBaseView.h"

typedef void (^DateSelectedBlock)(NSDate *selectedDate);

@interface XMDateSelectView : PopupBaseView
@property (nonatomic, copy) DateSelectedBlock selectedDateBlock;
@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;
@property (nonatomic, strong) NSDate *selectDate;
@end
