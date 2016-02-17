//
//  V2ExNodeCell.m
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExNodeCell.h"
#import "UIImageView+WebCache.h"

@implementation V2ExNodeCellUserData
@end

@interface V2ExNodeCell ()
//@property(nonatomic, strong) UIImageView *imageIcon;
@property(nonatomic, strong) UILabel *title;
@end

@implementation V2ExNodeCell

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

    //self.imageIcon = [UIImageView new];
   // self.imageIcon.contentMode = UIViewContentModeScaleToFill;
    //[self.contentView addSubview:self.imageIcon];
    [self.contentView addSubview:self.title];
    self.clipsToBounds = YES;
    [self makeConstraints];
  }
  return self;
}

- (void)makeConstraints {
//  [self.imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.left.equalTo(self.contentView).offset(15);
//    make.top.equalTo(self.contentView).offset(5);
//    make.height.mas_equalTo(44);
//    make.width.mas_equalTo(44);
//  }];

  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
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
  return 44;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (V2ExNodeCellUserData *)object.userInfo;
  self.title.text = self.userData.node.title;
  //NSURL *url = [NSURL
  //    URLWithString:[NSString stringWithFormat:@"http:%@",
  //                                             self.userData.node.avatar_mini]];
  //[self.imageIcon sd_setImageWithURL:url
  //                  placeholderImage:[UIImage imageNamed:@"img_lose"]];
  [self setNeedsLayout];

  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  V2ExNodeCellUserData *userData = [[V2ExNodeCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[V2ExNodeCell class]
                                     userInfo:userData];
  return cellObj;
}

@end
