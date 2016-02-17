//
//  V2ExNodeModel.h
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol V2ExNodeModel
@end

@interface V2ExNodeModel : JSONModel
@property(nonatomic) long _id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *title_alternative;
@property(nonatomic, strong) NSString *url;
@property(nonatomic) long topics;
@property(nonatomic, strong) NSString *avatar_mini;
@property(nonatomic, strong) NSString *avatar_normal;
@property(nonatomic, strong) NSString *avatar_large;
@end
