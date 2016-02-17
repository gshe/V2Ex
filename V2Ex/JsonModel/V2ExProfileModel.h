//
//  V2ExProfileModel.h
//  Floyd
//
//  Created by George She on 16/2/2.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, V2ExProfileType) {
  V2ExProfileType_Latest,
  V2ExProfileType_Categories,
  V2ExProfileType_Nodes,
  V2ExProfileType_Favorite,
  V2ExProfileType_Notification,
  V2ExProfileType_Profile
};

@interface V2ExProfileModel : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic) NSInteger count;
@property(nonatomic, strong) NSString *imageName;
@property(nonatomic) V2ExProfileType profileType;
@end
