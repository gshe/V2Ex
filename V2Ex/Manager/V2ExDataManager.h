//
//  V2ExDataManager.h
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "V2ExTopicModel.h"
#import "V2ExMemberModel.h"

@interface V2ExDataManager : NSObject
+ (instancetype)sharedInstance;
- (void)getHotTopicsWithCompletedBlock:
            (void (^)(NSArray<V2ExTopicModel> *ret))successBlock
                                failed:(void (^)(NSError *error))failedBlock;

- (void)getLatestTopicsWithCompletedBlock:
            (void (^)(NSArray<V2ExTopicModel> *ret))successBlock
                                   failed:(void (^)(NSError *error))failedBlock;

- (void)getTopics:(NSString *)nodeId
           nodeKey:(NSString *)nodeKey
              page:(NSInteger)page
    completedBlock:(void (^)(NSArray<V2ExTopicModel> *ret))successBlock
            failed:(void (^)(NSError *error))failedBlock;

- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
           completedBlock:(void (^)(NSString *message))successBlock
                   failed:(void (^)(NSError *error))failedBlock;

- (void)userLogout;
- (void)getCheckInURLSuccess:(void (^)(NSURL *URL))success
                     failure:(void (^)(NSError *error))failure;
- (void)getMemberProfileByUserId:(NSString *)userId
                        userName:(NSString *)userName
                  completedBlock:(void (^)(V2ExMemberModel *member))successBlock
                          failed:(void (^)(NSError *error))failedBlock;
@end
