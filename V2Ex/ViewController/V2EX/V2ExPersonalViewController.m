//
//  V2ExPersonalViewController.m
//  Floyd
//
//  Created by George She on 16/2/2.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExPersonalViewController.h"
#import "UIImageView+WebCache.h"
#import "V2ExCheckinManager.h"

@interface V2ExPersonalViewController ()
@property(nonatomic, strong) UIImageView *avatarView;
@property(nonatomic, strong) UILabel *userName;
@property(nonatomic, strong) UILabel *tagLine;
@property(nonatomic, strong) NITableViewActions *action;
@end

@implementation V2ExPersonalViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  [self createUI];
}

- (void)createUI {
  UIView *headerView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 100)];
  headerView.backgroundColor = [UIColor ex_globalBackgroundColor];
  self.avatarView = [UIImageView new];
  self.userName = [UILabel new];
  self.userName.font = Font_15;
  self.userName.textColor = [UIColor ex_mainTextColor];
  self.tagLine = [UILabel new];
  self.tagLine.textColor = [UIColor ex_subTextColor];
  self.tagLine.font = Font_12;
  [headerView addSubview:self.avatarView];
  [headerView addSubview:self.userName];
  [headerView addSubview:self.tagLine];

  [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(headerView).offset(15);
    make.top.equalTo(headerView).offset(15);
    make.width.mas_equalTo(44);
    make.height.mas_equalTo(44);
  }];

  [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avatarView.mas_right).offset(15);
    make.top.equalTo(self.avatarView);

  }];

  [self.tagLine mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avatarView.mas_right).offset(15);
    make.top.equalTo(self.userName.mas_bottom).offset(15);
  }];
  V2ExMemberModel *member = [V2ExCheckinManager sharedInstance].curUser;
  NSURL *url =
      [NSURL URLWithString:[NSString stringWithFormat:@"http:%@",
                                                      member.avatar_large]];
  [self.avatarView sd_setImageWithURL:url
                     placeholderImage:[UIImage imageNamed:@"img_lose"]];
  self.userName.text = member.username;
  self.tagLine.text = member.tagline;
  self.tableView.tableHeaderView = headerView;

  self.action = [[NITableViewActions alloc] initWithTarget:self];

  NSMutableArray *contents = [@[] mutableCopy];
  [contents addObject:@"社区"];
  NICellObject *topic = [self.action
      attachToObject:[NITitleCellObject
                         objectWithTitle:@"主题"
                                   image:[UIImage imageNamed:@"profile_topic"]]
         tapSelector:@selector(topicTapped)];
  [contents addObject:topic];

  NICellObject *reply = [self.action
      attachToObject:[NITitleCellObject
                         objectWithTitle:@"回复"
                                   image:[UIImage imageNamed:@"profile_reply"]]
         tapSelector:@selector(replyTapped)];
  [contents addObject:reply];
  [contents addObject:@"信息"];
  if (member.location) {
    [contents
        addObject:[NITitleCellObject
                      objectWithTitle:member.location
                                image:[UIImage
                                          imageNamed:@"profile_location"]]];
  }
  if (member.twitter) {
    [contents
        addObject:[NITitleCellObject
                      objectWithTitle:member.twitter
                                image:[UIImage imageNamed:@"profile_twitter"]]];
  }
  if (member.github) {
    [contents
        addObject:[NITitleCellObject
                      objectWithTitle:member.github
                                image:[UIImage imageNamed:@"profile_link"]]];
  }
  [contents addObject:@"个人简介"];
  if (member.bio) {
    [contents addObject:[NITitleCellObject objectWithTitle:member.bio]];
  } else {
    [contents addObject:[NITitleCellObject objectWithTitle:@"没有简介"]];
  }
  self.tableView.delegate = [self.action forwardingTo:self];
  [self setTableData:contents];
}

- (void)topicTapped {
	
}

- (void)replyTapped {
	
}
#pragma action

@end
