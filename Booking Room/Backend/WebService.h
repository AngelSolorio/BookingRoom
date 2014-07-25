//
//  WebService.h
//  Vodafone
//
//  Created by Angel Solorio on 3/26/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.


#import "AFHTTPSessionManager.h"
#import "FeedUserDefaults.h"

@interface WebService : AFHTTPSessionManager

+ (WebService *)sharedClient;

- (NSURLSessionDataTask *)logingUser:(NSString *)user password:(NSString *)password completion:(void (^)(NSDictionary *results, NSError *error))completion;
- (NSURLSessionDataTask *)getLoggedUserInfo_completion:(void (^)(NSDictionary *results, NSError *error))completion;
- (NSURLSessionDataTask *)sendComment:(NSString *)comment idLogs:(NSInteger)idLogs completion:(void (^)(NSDictionary *results, NSError *error))completion;

- (NSMutableURLRequest *)getURLRequestForPictureID:(NSString *)pictureID andType:(NSString *)type;

@end
