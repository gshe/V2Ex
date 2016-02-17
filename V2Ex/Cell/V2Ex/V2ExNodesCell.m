//
//  V2ExNodesCell.m
//  Floyd
//
//  Created by George She on 16/2/2.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExNodesCell.h"
#import "V2ExNodeModel.h"
#import <objc/runtime.h>
@interface UIButton (V2ExNodes)
@property(nonatomic, strong) V2ExNodeModel *model;
@end

@implementation V2ExNodesCellUserData
@end

@interface V2ExNodesCell ()

@end

@implementation V2ExNodesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.clipsToBounds = YES;
    [self makeConstraints];
  }
  return self;
}

- (void)makeConstraints {
}

- (void)dealloc {
  self.userData = nil;
}
- (void)prepareForReuse {
  [super prepareForReuse];
  for (UIView *view in self.contentView.subviews) {
    if ([view isKindOfClass:[UIButton class]]) {
      if (view.superview) {
        [view removeFromSuperview];
      }
    }
  }
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
  NICellObject *cellObj = (NICellObject *)object;
  V2ExNodesCellUserData *userData = cellObj.userInfo;
  CGFloat maxWidth = WIDTH(tableView) - 20;
  CGFloat totalHeight = 30;
  CGFloat remainingWidth = maxWidth;
  for (V2ExNodeModel *node in userData.nodeArr) {
    CGSize btnSize =
        [node.title lineBreakSizeExOfStringwithFont:Font_15
                                           maxwidth:remainingWidth
                                      lineBreakMode:NSLineBreakByWordWrapping];
    if (btnSize.height > 20) {
      totalHeight += 25;
      remainingWidth = maxWidth;
      CGSize btnSize2 = [node.title
          lineBreakSizeExOfStringwithFont:Font_15
                                 maxwidth:remainingWidth
                            lineBreakMode:NSLineBreakByWordWrapping];
      remainingWidth -= btnSize2.width + 25;
    } else {
      remainingWidth -= btnSize.width + 25;
    }
  }
  return totalHeight;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (V2ExNodesCellUserData *)object.userInfo;
  [self addButtons];
  [self setNeedsLayout];

  return YES;
}

- (void)addButtons {
  CGFloat maxWidth = kScreenWidth - 20;
  CGFloat startY = 5;
  CGFloat startX = 10;
  CGFloat remainingWidth = maxWidth;
  for (V2ExNodeModel *node in self.userData.nodeArr) {
    CGSize btnSize =
        [node.title lineBreakSizeExOfStringwithFont:Font_15
                                           maxwidth:remainingWidth
                                      lineBreakMode:NSLineBreakByWordWrapping];
    if (btnSize.height > 20) {
      startY += 25;
      remainingWidth = maxWidth;
      btnSize = [node.title
          lineBreakSizeExOfStringwithFont:Font_15
                                 maxwidth:remainingWidth
                            lineBreakMode:NSLineBreakByWordWrapping];
      startX = 10;
      remainingWidth -= btnSize.width + 15 + 10;
    } else {
      remainingWidth -= btnSize.width + 15 + 10;
    }

    CGRect btnFrame = CGRectMake(startX, startY, btnSize.width + 15, 20);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = btnFrame;
    btn.model = node;
    [btn setTitle:node.title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor ex_blueTextColor]
              forState:UIControlStateNormal];
    [btn addTarget:self
                  action:@selector(nodeButtonPressed:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];

    startX += btnSize.width + 15 + 10;
  }
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  V2ExNodesCellUserData *userData = [[V2ExNodesCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[V2ExNodesCell class]
                                     userInfo:userData];
  return cellObj;
}

- (void)nodeButtonPressed:(id)sender {
  UIButton *btn = sender;
  if ([btn isKindOfClass:[UIButton class]]) {
    V2ExNodeModel *nodeModel = btn.model;
    if ([self.userData.delegate respondsToSelector:@selector(nodeSelected:)]) {
      [self.userData.delegate nodeSelected:nodeModel];
    }
  }
}

@end

@implementation UIButton (V2ExNodes)
- (V2ExNodeModel *)model {
  return objc_getAssociatedObject(self, @selector(model));
}

- (void)setModel:(V2ExNodeModel *)model {
  objc_setAssociatedObject(self, @selector(model), model,
                           OBJC_ASSOCIATION_RETAIN);
}

@end