//
//  V2ExProfileCell.m
//  Floyd
//
//  Created by George She on 16/2/2.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExProfileCell.h"

@implementation V2ExProfileCellUserData
@end

@interface V2ExProfileCell ()
@property(nonatomic, strong) UIImageView *imageIcon;
@property(nonatomic, strong) UILabel *title;
@end

@implementation V2ExProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.title = [UILabel new];
    self.title.font = Font_15;
    self.title.textColor = [UIColor ex_mainTextColor];
    self.title.textAlignment = NSTextAlignmentCenter;

    self.imageIcon = [UIImageView new];
    self.imageIcon.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.imageIcon];
    [self.contentView addSubview:self.title];
    self.clipsToBounds = YES;
    [self makeConstraints];
  }
  return self;
}

- (void)makeConstraints {
  [self.imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.centerY.equalTo(self.contentView);
    make.height.mas_equalTo(16);
    make.width.mas_equalTo(16);
  }];

  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.imageIcon.mas_right).offset(15);
    make.right.lessThanOrEqualTo(self.contentView).offset(-15);
    make.centerY.equalTo(self.contentView);
  }];
}

- (void)dealloc {
  self.userData = nil;
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
  return 64;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (V2ExProfileCellUserData *)object.userInfo;
  self.title.text = self.userData.profileItem.title;
  self.imageIcon.image =
      [UIImage imageNamed:self.userData.profileItem.imageName];
  [self setNeedsLayout];

  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  V2ExProfileCellUserData *userData = [[V2ExProfileCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[V2ExProfileCell class]
                                     userInfo:userData];
  return cellObj;
}

@end
