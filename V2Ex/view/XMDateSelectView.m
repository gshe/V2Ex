//
//  XMBirthdaySelectView.h
//  xmLife
//
//  Created by shezhiqiang on 15/12/16.
//  Copyright (c) 2015年 PaiTao. All rights reserved.
//

#import "XMDateSelectView.h"
#import <UIKit/UIKit.h>

@interface XMDateSelectView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIButton *btnCancel;

@end
@implementation XMDateSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        UITapGestureRecognizer *tap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
        [self makeUI];
    }
    return self;
}

- (void)makeUI
{
    _containerView =
        [[UIView alloc] initWithFrame:CGRectMake(15, HEIGHT(self), WIDTH(self) - 30, 250)];
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.layer.cornerRadius = 10;
    _containerView.layer.masksToBounds = YES;
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_datePicker addTarget:self
                    action:@selector(dateChange:)
          forControlEvents:UIControlEventValueChanged];
    [_containerView addSubview:_datePicker];

    _btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnDone setTitleColor:[UIColor ex_blueTextColor] forState:UIControlStateNormal];
    [_btnDone setTitle:@"确定" forState:UIControlStateNormal];
    [_btnDone addTarget:self
                  action:@selector(doneAction:)
        forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_btnDone];

    _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnCancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel addTarget:self
                   action:@selector(cancelAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_btnCancel];
    [self addSubview:_containerView];

    [_btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(_containerView).offset(15);
      make.top.equalTo(_containerView).offset(5);
      make.height.mas_equalTo(40);
    }];

    [_btnDone mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(_containerView).offset(-15);
      make.top.equalTo(_containerView).offset(5);
      make.height.mas_equalTo(40);
    }];

    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(_btnDone.mas_bottom).offset(5);
      make.height.mas_equalTo(200);
      make.left.equalTo(_containerView).offset(15);
      make.right.equalTo(_containerView).offset(-15);
    }];
}

#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap
{
    [self dismiss];
}

#pragma mark - Action
- (void)show
{
    [super show];
    CGRect blockViewRect = _containerView.frame;
    blockViewRect.origin.y -= 250 + 15;
    [UIView animateWithDuration:0.25
                     animations:^{
                       _containerView.frame = blockViewRect;
                     }];
}

- (void)dismiss
{
    CGRect blockViewRect = _containerView.frame;
    blockViewRect.origin.y = HEIGHT(self);
    [UIView animateWithDuration:0.25
        animations:^{
          _containerView.frame = blockViewRect;
        }
        completion:^(BOOL finished) {
          self.selectedDateBlock = nil;
          [super dismiss];
        }];
}

- (void)doneAction:(UIButton *)btn
{
    if (self.selectedDateBlock) {
        self.selectedDateBlock(_datePicker.date);
    }
    [self dismiss];
}

- (void)cancelAction:(UIButton *)btn
{
    [self dismiss];
}

- (void)dateChange:(id)datePicker
{
}

#pragma mark - setter、getter

- (void)setMinimumDate:(NSDate *)minimumDate
{
    _datePicker.minimumDate = minimumDate;
}

- (void)setMaximumDate:(NSDate *)maximumDate
{
    _datePicker.maximumDate = maximumDate;
}

- (void)setSelectDate:(NSDate *)selectDate
{
    [_datePicker setDate:selectDate animated:YES];
}

@end
