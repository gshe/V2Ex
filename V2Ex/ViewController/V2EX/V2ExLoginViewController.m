//
//  V2ExLoginViewController.m
//  Floyd
//
//  Created by George She on 16/2/2.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExLoginViewController.h"
#import "v2ExDataManager.h"

@interface V2ExLoginViewController ()
@property(nonatomic, strong) UITextField *userName;
@property(nonatomic, strong) UITextField *password;
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UIButton *closeButton;

@property(nonatomic, strong) V2ExDataManager *manager;
@end

@implementation V2ExLoginViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor ex_globalBackgroundColor];
  [self createUI];
}

- (void)createUI {
  self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.closeButton setImage:[UIImage imageNamed:@"close"]
                    forState:UIControlStateNormal];
  [self.view addSubview:self.closeButton];
  [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(15);
    make.top.equalTo(self.view).offset(35);
    make.width.mas_equalTo(44);
    make.height.mas_equalTo(44);

  }];
  [self.closeButton addTarget:self
                       action:@selector(closeButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];

  UIView *contentView = [UIView new];
  contentView.layer.cornerRadius = 2;
  contentView.backgroundColor = [UIColor whiteColor];

  UILabel *userNameLable = [UILabel new];
  userNameLable.text = @"用户名";
  UILabel *passwordLable = [UILabel new];
  passwordLable.text = @"密码";
  self.userName = [UITextField new];
  self.userName.placeholder = @"请输入用户名";
  self.password = [UITextField new];
  self.password.placeholder = @"请输入密码";
  self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
  [self.loginButton setTitleColor:[UIColor ex_blueTextColor]
                         forState:UIControlStateNormal];
  self.loginButton.layer.borderWidth = 1;
  self.loginButton.layer.cornerRadius = 4;
  self.loginButton.layer.borderColor = [UIColor ex_greenTextColor].CGColor;
  [self.loginButton addTarget:self
                       action:@selector(loginButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
  [contentView addSubview:userNameLable];
  [contentView addSubview:passwordLable];
  [contentView addSubview:self.userName];
  [contentView addSubview:self.password];
  [contentView addSubview:self.loginButton];
  [self.view addSubview:contentView];

  [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(15);
    make.right.equalTo(self.view).offset(-15);
    make.centerY.equalTo(self.view);
    make.height.mas_equalTo(150);
  }];

  [userNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(contentView).offset(15);
    make.top.equalTo(contentView).offset(15);
  }];
  [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(contentView).offset(75);
    make.top.equalTo(contentView).offset(15);
  }];
  [passwordLable mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(contentView).offset(15);
    make.top.equalTo(userNameLable.mas_bottom).offset(15);
  }];
  [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(contentView).offset(75);
    make.top.equalTo(userNameLable.mas_bottom).offset(15);
  }];
  [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(contentView);
    make.bottom.equalTo(contentView.mas_bottom).offset(-15);
    make.width.mas_equalTo(96);
    make.height.mas_equalTo(36);
  }];
}

- (void)closeButtonPressed:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginButtonPressed:(id)sender {
  [self showHUD];
  if (!self.manager) {
    self.manager = [[V2ExDataManager alloc] init];
  }

  [self.manager loginWithUserName:self.userName.text
      password:self.password.text
      completedBlock:^(NSString *message) {
        [self hideAllHUDs];
        [self dismissViewControllerAnimated:YES completion:nil];
      }
      failed:^(NSError *error) {
        [self showError:error];
        [self hideAllHUDs];
      }];
}
@end
