//
//  MyV2ExProfileViewController.m
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "MyV2ExProfileViewController.h"
#import "V2ExProfileCell.h"
#import "V2ExDataManager.h"
#import "V2ExCheckInManager.h"
#import "UIImageView+WebCache.h"
#import "V2ExCheckinManager.h"

@interface MyV2ExProfileViewController ()
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UIImageView *avatarView;
@property(nonatomic, strong) NSMutableArray *profiles;
@end

@implementation MyV2ExProfileViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(checkInStatusChanged)
             name:kV2ExCheckInStatusChanged
           object:nil];
  [self createView];
  [self refreshData];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)createView {
  UIView *headerView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 150)];
  headerView.backgroundColor = [UIColor ex_globalBackgroundColor];

  self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
  [self.loginButton setTitleColor:[UIColor ex_blueTextColor]
                         forState:UIControlStateNormal];
  [self.loginButton addTarget:self
                       action:@selector(loginButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];

  self.avatarView = [UIImageView new];
  self.avatarView.layer.cornerRadius = 44 / 2;
  self.avatarView.layer.borderWidth = 1;
  self.avatarView.layer.borderColor = [UIColor ex_greenTextColor].CGColor;
  self.avatarView.clipsToBounds = YES;
  [headerView addSubview:self.avatarView];
  [headerView addSubview:self.loginButton];
  [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(headerView);
  }];
  [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(headerView);
    make.width.mas_equalTo(44);
    make.height.mas_equalTo(44);
  }];
  self.tableView.tableHeaderView = headerView;
}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [[V2ExCheckinManager sharedInstance] updateUserInfo];
}
- (void)refreshData {
  if ([V2ExCheckinManager sharedInstance].curUser.isFound) {
    self.loginButton.hidden = YES;
    self.avatarView.hidden = NO;
    NSURL *url = [NSURL
        URLWithString:[NSString
                          stringWithFormat:@"http:%@",
                                           [V2ExCheckinManager sharedInstance]
                                               .curUser.avatar_large]];
    [self.avatarView sd_setImageWithURL:url
                       placeholderImage:[UIImage imageNamed:@"img_lose"]];
  } else {
    self.loginButton.hidden = NO;
    self.avatarView.hidden = YES;
  }

  self.profiles = [NSMutableArray array];
  V2ExProfileModel *profile = [[V2ExProfileModel alloc] init];
  profile.title = @"最新";
  profile.profileType = V2ExProfileType_Latest;
  profile.imageName = @"section_latest";
  [self.profiles addObject:profile];
  profile = [[V2ExProfileModel alloc] init];
  profile.title = @"分类";
  profile.profileType = V2ExProfileType_Categories;
  profile.imageName = @"section_categories";
  [self.profiles addObject:profile];
  profile = [[V2ExProfileModel alloc] init];
  profile.title = @"节点";
  profile.profileType = V2ExProfileType_Nodes;
  profile.imageName = @"section_nodes";
  [self.profiles addObject:profile];
  profile = [[V2ExProfileModel alloc] init];
  profile.title = @"收藏";
  profile.profileType = V2ExProfileType_Favorite;
  profile.imageName = @"section_fav";
  [self.profiles addObject:profile];
  profile = [[V2ExProfileModel alloc] init];
  profile.title = @"提醒";
  profile.profileType = V2ExProfileType_Notification;
  profile.imageName = @"section_notification";
  [self.profiles addObject:profile];
  profile = [[V2ExProfileModel alloc] init];
  profile.title = @"个人";
  profile.profileType = V2ExProfileType_Profile;
  profile.imageName = @"section_profile";
  [self.profiles addObject:profile];
  NSMutableArray *contents = [@[] mutableCopy];
  for (V2ExProfileModel *item in self.profiles) {
    V2ExProfileCellUserData *userData = [[V2ExProfileCellUserData alloc] init];
    userData.profileItem = item;
    [contents addObject:[[NICellObject alloc]
                            initWithCellClass:[V2ExProfileCell class]
                                     userInfo:userData]];
  }
  [self setTableData:contents];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  if ([cell isKindOfClass:[V2ExProfileCell class]]) {
    V2ExProfileCell *profileCell = (V2ExProfileCell *)cell;
    V2ExProfileCellUserData *userData = profileCell.userData;
    if ([self.delegate respondsToSelector:@selector(profileItemSelected:)]) {
      [self.delegate profileItemSelected:userData.profileItem];
    }
  }
}

- (void)loginButtonPressed:(id)sender {
  if ([self.delegate respondsToSelector:@selector(doLogin)]) {
    [self.delegate doLogin];
  }
}

- (void)checkInStatusChanged {
  [self refreshData];
}
@end
