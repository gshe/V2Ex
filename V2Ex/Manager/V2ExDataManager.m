//
//  V2ExDataManager.m
//  Floyd
//
//  Created by George She on 16/2/1.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "V2ExDataManager.h"
#import "AFNetworking.h"
#import "HTMLParser.h"
#import "V2ExCheckinManager.h"

#define BASE_URL @"https://www.v2ex.com/"
static NSString *const kOnceString = @"once";
static NSString *const kNextString = @"next";

static NSString *const kUsername = @"username";
static NSString *const kUserid = @"userid";
static NSString *const kAvatarURL = @"avatarURL";
static NSString *const kUserIsLogin = @"userIsLogin";

@interface V2ExDataManager ()
@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation V2ExDataManager
+ (instancetype)sharedInstance {
  static V2ExDataManager *manager;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [[V2ExDataManager alloc] init];
  });
  return manager;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.sessionManager = [[AFHTTPSessionManager alloc]
        initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    self.sessionManager.responseSerializer =
        [AFJSONResponseSerializer serializer];
  }
  return self;
}

- (void)getHotTopicsWithCompletedBlock:
            (void (^)(NSArray<V2ExTopicModel> *))successBlock
                                failed:(void (^)(NSError *error))failedBlock {
  NSString *url = [NSString stringWithFormat:@"api/topics/%@.json", @"hot"];
  [self getTopics:url
          parameters:nil
      completedBlock:successBlock
              failed:failedBlock];
}

- (void)getLatestTopicsWithCompletedBlock:
            (void (^)(NSArray<V2ExTopicModel> *ret))successBlock
                                   failed:
                                       (void (^)(NSError *error))failedBlock {
  NSString *url = [NSString stringWithFormat:@"api/topics/%@.json", @"latest"];
  [self getTopics:url
          parameters:nil
      completedBlock:successBlock
              failed:failedBlock];
}

- (void)getTopics:(NSString *)url
        parameters:(NSDictionary *)parameters
    completedBlock:(void (^)(NSArray<V2ExTopicModel> *ret))successBlock
            failed:(void (^)(NSError *error))failedBlock {
  self.sessionManager.responseSerializer =
      [AFJSONResponseSerializer serializer];
  [self.sessionManager GET:url
      parameters:parameters
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nonnull responseObject) {
        NSError *error;
        NSMutableArray<V2ExTopicModel> *topics = [@[] mutableCopy];
        if ([responseObject isKindOfClass:[NSArray class]]) {
          for (id item in responseObject) {
            V2ExTopicModel *topic =
                [[V2ExTopicModel alloc] initWithDictionary:item error:&error];
            if (topic) {
              [topics addObject:topic];
            }
          }
        }
        if (!error) {
          successBlock(topics);
        } else {
          failedBlock(error);
        }
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        failedBlock(error);
      }];
}

- (void)getTopics:(NSString *)nodeId
           nodeKey:(NSString *)nodeKey
              page:(NSInteger)page
    completedBlock:(void (^)(NSArray<V2ExTopicModel> *))successBlock
            failed:(void (^)(NSError *))failedBlock {
  NSDictionary *parameters;
  if (nodeId) {
    parameters = @{ @"node_id" : nodeId, @"p" : @(page) };
  }
  if (nodeKey) {
    parameters = @{ @"node_name" : nodeKey, @"p" : @(page) };
  }

  NSString *url = @"api/topics/show.json";
  [self getTopics:url
          parameters:parameters
      completedBlock:successBlock
              failed:failedBlock];
}

- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
           completedBlock:(void (^)(NSString *))successBlock
                   failed:(void (^)(NSError *))failedBlock {

  NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
  for (NSHTTPCookie *cookie in [storage cookies]) {
    [storage deleteCookie:cookie];
  }

  self.sessionManager.responseSerializer =
      [AFJSONResponseSerializer serializer];
  [self requestOnceWithURLString:@"/signin"
      success:^(NSString *onceString) {
        NSDictionary *parameters = @{
          kOnceString : onceString,
          kNextString : @"/", @"p" : password, @"u" : userName,
        };
        [self.sessionManager.requestSerializer
                      setValue:@"http://v2ex.com/signin"
            forHTTPHeaderField:@"Referer"];
        [self.sessionManager POST:@"/signin"
            parameters:parameters
            success:^(NSURLSessionDataTask *_Nonnull task,
                      id _Nonnull responseObject) {
              NSString *htmlString =
                  [[NSString alloc] initWithData:responseObject
                                        encoding:NSUTF8StringEncoding];

              if ([htmlString rangeOfString:@"/notifications"].location !=
                  NSNotFound) {
                [V2ExCheckinManager sharedInstance].userName = userName;
                [[V2ExCheckinManager sharedInstance] updateStatus];
                successBlock(userName);
              } else {
                NSError *err = [[NSError alloc] initWithDomain:@"login Faield"
                                                          code:1
                                                      userInfo:nil];
                failedBlock(err);
              }
            }
            failure:^(NSURLSessionDataTask *_Nullable task,
                      NSError *_Nonnull error) {
              failedBlock(error);
            }];
      }
      failure:^(NSError *error) {
        failedBlock(error);
      }];
}

- (void)userLogout {

  NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
  for (NSHTTPCookie *cookie in [storage cookies]) {
    [storage deleteCookie:cookie];
  }
  [[V2ExCheckinManager sharedInstance] resetStatus];
}

- (void)getCheckInURLSuccess:(void (^)(NSURL *URL))success
                     failure:(void (^)(NSError *error))failure {
  self.sessionManager.responseSerializer =
      [AFHTTPResponseSerializer serializer];
  [self.sessionManager GET:@"/mission/daily"
      parameters:nil
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nonnull responseObject) {
        NSString *checkInString =
            [self getCheckInUrlStringFromHtmlResponseObject:responseObject];
        if (checkInString) {
          NSURL *checkInURL = [NSURL URLWithString:checkInString];
          success(checkInURL);
        } else {
          NSError *error = [[NSError alloc]
              initWithDomain:self.sessionManager.baseURL.absoluteString
                        code:1
                    userInfo:nil];
          failure(error);
        }
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        failure(error);
      }];
}

- (void)getMemberProfileByUserId:(NSString *)userId
                        userName:(NSString *)userName
                  completedBlock:(void (^)(V2ExMemberModel *))successBlock
                          failed:(void (^)(NSError *))failedBlock {
  NSDictionary *parameters;
  if (userId) {
    parameters = @{
      @"id" : userId,
    };
  }
  if (userName) {
    parameters = @{
      @"username" : userName,
    };
  }
  self.sessionManager.responseSerializer =
      [AFJSONResponseSerializer serializer];
  [self.sessionManager GET:@"/api/members/show.json"
      parameters:parameters
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
          V2ExMemberModel *member =
              [[V2ExMemberModel alloc] initWithDictionary:responseObject
                                                    error:nil];
          successBlock(member);
        } else {
          failedBlock(nil);
        }
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        failedBlock(error);
      }];
}
#pragma mark - Private Methods

- (void)requestOnceWithURLString:(NSString *)urlString
                         success:(void (^)(NSString *onceString))success
                         failure:(void (^)(NSError *error))failure {
  self.sessionManager.responseSerializer =
      [AFHTTPResponseSerializer serializer];
  [self.sessionManager GET:urlString
      parameters:nil
      success:^(NSURLSessionDataTask *_Nonnull task,
                id _Nonnull responseObject) {
        NSString *onceString =
            [self getOnceStringFromHtmlResponseObject:responseObject];
        success(onceString);
      }
      failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        failure(error);
      }];
}

- (NSString *)getOnceStringFromHtmlResponseObject:(id)responseObject {

  __block NSString *onceString;

  @autoreleasepool {
    NSString *htmlString = [[NSString alloc] initWithData:responseObject
                                                 encoding:NSUTF8StringEncoding];

    NSError *error = nil;
    HTMLParser *parser =
        [[HTMLParser alloc] initWithString:htmlString error:&error];

    if (error) {
      NSLog(@"Error: %@", error);
    }

    HTMLNode *bodyNode = [parser body];

    NSArray *inputNodes = [bodyNode findChildTags:@"input"];

    [inputNodes enumerateObjectsUsingBlock:^(HTMLNode *aNode, NSUInteger idx,
                                             BOOL *stop) {

      if ([[aNode getAttributeNamed:@"name"] isEqualToString:@"once"]) {
        onceString = [aNode getAttributeNamed:@"value"];
      }

    }];
  }

  return onceString;
}

- (NSString *)getCheckInUrlStringFromHtmlResponseObject:(id)responseObject {

  __block NSString *checkInUrlString;

  @autoreleasepool {
    NSString *htmlString = [[NSString alloc] initWithData:responseObject
                                                 encoding:NSUTF8StringEncoding];

    __block NSString *onceToken;

    NSError *error = nil;
    HTMLParser *parser =
        [[HTMLParser alloc] initWithString:htmlString error:&error];

    if (error) {
      NSLog(@"Error: %@", error);
    }

    HTMLNode *bodyNode = [parser body];

    NSArray *inputNodes = [bodyNode findChildTags:@"input"];

    [inputNodes enumerateObjectsUsingBlock:^(HTMLNode *aNode, NSUInteger idx,
                                             BOOL *stop) {

      NSString *hrefString = [aNode getAttributeNamed:@"onclick"];
      if (hrefString) {
        onceToken = [hrefString
            stringByReplacingOccurrencesOfString:@"location.href = '"
                                      withString:@""];
        onceToken = [onceToken stringByReplacingOccurrencesOfString:@"';"
                                                         withString:@""];
        *stop = YES;
      }

    }];

    if (onceToken) {
      checkInUrlString = onceToken;
    }
  }

  return checkInUrlString;
}

@end
