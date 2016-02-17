//
//  AreaPickView.m
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "AreaPickView.h"
@interface AreaPickView () <UIPickerViewDelegate, UIPickerViewDataSource>
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIPickerView *areaPickerView;
@property(nonatomic, strong) NSArray *arrCityKeys;
@end

@implementation AreaPickView
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self loadView];
  }
  return self;
}

- (void)setCitesInProvinceDic:(NSDictionary *)citesInProvinceDic {
  _citesInProvinceDic = citesInProvinceDic;
  _arrCityKeys = _citesInProvinceDic.allKeys;
}

- (void)loadView {
  self.contentView = [UIView new];
  self.contentView.backgroundColor = [UIColor whiteColor];
  self.contentView.layer.cornerRadius = 4;

  UIView *titleBarView = [UIView new];
  titleBarView.backgroundColor = [UIColor lightGrayColor];

  self.areaPickerView = [UIPickerView new];
  self.areaPickerView.delegate = self;
  self.areaPickerView.dataSource = self;
  [self.contentView addSubview:titleBarView];
  [self.contentView addSubview:self.areaPickerView];
  [self addSubview:self.contentView];

  UIButton *cancelButton = [UIButton new];
  [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
  [cancelButton addTarget:self
                   action:@selector(cancelButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
  UIButton *confirmButton = [UIButton new];
  [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
  [confirmButton addTarget:self
                    action:@selector(confirmButtonPressed:)
          forControlEvents:UIControlEventTouchUpInside];

  [titleBarView addSubview:confirmButton];
  [titleBarView addSubview:cancelButton];

  [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(titleBarView).offset(15);
    make.centerY.equalTo(titleBarView);

  }];
  [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(titleBarView).offset(-15);
    make.centerY.equalTo(titleBarView);

  }];
  [titleBarView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView);
    make.right.equalTo(self.contentView);
    make.top.equalTo(self.contentView);
    make.height.mas_equalTo(44);
  }];

  [self.areaPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).offset(15);
    make.right.equalTo(self).offset(-15);
    make.top.equalTo(titleBarView.mas_bottom).offset(5);
    make.bottom.equalTo(self.contentView).offset(-15);
  }];

  [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).offset(15);
    make.right.equalTo(self).offset(-15);
    make.height.mas_equalTo(320);
    make.centerY.equalTo(self);
  }];
}

- (void)cancelButtonPressed:(id)sender {
  [self dismiss];
}

- (void)confirmButtonPressed:(id)sender {
  NSInteger row = [self.areaPickerView selectedRowInComponent:0];
  NSString *cityName = self.arrCityKeys[row];
  NSString *areaId = self.citesInProvinceDic[cityName];
  if ([self.delegate
          respondsToSelector:@selector(didSelectAreaWithCityName:andAreaId:)]) {
    [self.delegate didSelectAreaWithCityName:cityName andAreaId:areaId];

    [self dismiss];
  }
}

#pragma UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
  return self.arrCityKeys[row];
}

#pragma UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView
    numberOfRowsInComponent:(NSInteger)component {
  return self.arrCityKeys.count;
}
@end
