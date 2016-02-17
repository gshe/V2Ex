//
//  V2ExTopicCell.m
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExTopicCell.h"
#import "UIImageView+WebCache.h"

@implementation V2ExTopicCellUserData
@end

@interface V2ExTopicCell ()
@property(nonatomic, strong) UIImageView *avatarImage;
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *modifyTime;
@property(nonatomic, strong) UILabel *userName;
@property(nonatomic, strong) UILabel *node;
@end

@implementation V2ExTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.title = [UILabel new];
    self.title.font = Font_15;
    self.title.textColor = [UIColor ex_mainTextColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.numberOfLines = 2;
    self.title.lineBreakMode = NSLineBreakByTruncatingTail;

    self.modifyTime = [UILabel new];
    self.modifyTime.font = Font_12;
    self.modifyTime.textColor = [UIColor ex_subTextColor];
    self.modifyTime.textAlignment = NSTextAlignmentLeft;

    self.avatarImage = [UIImageView new];
    self.avatarImage.contentMode = UIViewContentModeScaleToFill;

    self.userName = [UILabel new];
    self.userName.font = Font_12;
    self.userName.textColor = [UIColor ex_subTextColor];
    self.userName.textAlignment = NSTextAlignmentRight;

    self.node = [UILabel new];
    self.node.font = Font_12;
    self.node.textColor = [UIColor ex_subTextColor];
    self.node.textAlignment = NSTextAlignmentRight;
    self.node.backgroundColor = [UIColor ex_noteTextColor];

    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.modifyTime];
    [self.contentView addSubview:self.userName];
    [self.contentView addSubview:self.node];
    self.clipsToBounds = YES;
    [self makeConstraints];
  }
  return self;
}

- (void)makeConstraints {
  [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.contentView).offset(-15);
    make.top.equalTo(self.contentView).offset(15);
    make.height.mas_equalTo(44);
    make.width.mas_equalTo(44);
  }];

  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.right.lessThanOrEqualTo(self.avatarImage.mas_left).offset(-5);
    make.top.equalTo(self.contentView).offset(15);
  }];

  [self.modifyTime mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.right.lessThanOrEqualTo(self.userName.mas_left).offset(-5);
    make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
  }];

  [self.node mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.contentView.mas_right).offset(-15);
    make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
  }];

  [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.node.mas_left).offset(-5);
    make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
  }];
}

- (void)dealloc {
  self.userData = nil;
}
- (void)prepareForReuse {
  [super prepareForReuse];
  self.title.text = nil;
  self.modifyTime.text = nil;
  self.userName.text = nil;
  self.node.text = nil;
  self.avatarImage.image = nil;
  [self setNeedsLayout];
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
  //  NICellObject *obj = object;
  //  V2ExTopicCellUserData *userData = (V2ExTopicCellUserData *)obj.userInfo;
  //  CGFloat maxWidth = WIDTH(tableView) - 30 - 44 - 5;
  //  CGFloat height = [userData.topic.content
  //      lineBreakSizeOfStringwithFont:Font_20
  //                           maxwidth:maxWidth
  //                      lineBreakMode:NSLineBreakByTruncatingTail];
  //  if (height > 20) {
  //
  //  } else if (height > 40) {
  //
  //  } else {
  //  }
  return 95;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (V2ExTopicCellUserData *)object.userInfo;
  self.title.text = self.userData.topic.title;
  self.modifyTime.text = self.userData.topic.last_modifiedStr;
  //[NSString stringWithFormat:@"%ld", self.userData.topic.last_modified];
  self.userName.text = self.userData.topic.member.username;
  self.node.text = self.userData.topic.node.title;
  NSURL *url =
      [NSURL URLWithString:[NSString stringWithFormat:@"http:%@",
                                                      self.userData.topic.member
                                                          .avatar_large]];
  [self.avatarImage sd_setImageWithURL:url
                      placeholderImage:[UIImage imageNamed:@"img_lose"]];
  [self setNeedsLayout];
  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  V2ExTopicCellUserData *userData = [[V2ExTopicCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[V2ExTopicCell class]
                                     userInfo:userData];
  return cellObj;
}
@end
