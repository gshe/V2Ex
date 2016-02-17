//
//  AreaPickView.h
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "PopupBaseView.h"
@protocol AreaPickViewDelegate <NSObject>
- (void)didSelectAreaWithCityName:(NSString *)cityName
                        andAreaId:(NSString *)areaId;
@end

@interface AreaPickView : PopupBaseView
@property(nonatomic, strong) NSDictionary *citesInProvinceDic;
@property(nonatomic, weak) id<AreaPickViewDelegate> delegate;
@end
