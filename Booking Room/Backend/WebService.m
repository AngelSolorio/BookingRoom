//
//  WebService.m
//  Vodafone
//
//  Created by Angel Solorio on 3/26/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.


#import "WebService.h"

#define kBASE_URL @"http://172.20.112.97:3000"
#define kDATE_FORMAT @"yyyy-MM-dd HH:mm:ss"
#define kSHORT_DATEFORMAT @"yyyy-MM-dd"


@implementation WebService

+ (WebService *)sharedClient {
    static WebService *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{@"Content-Type" : @"application/x-www-form-urlencoded"}];

        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];

        [config setURLCache:cache];

        _sharedClient = [[WebService alloc] initWithSessionConfiguration:config];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });

    return _sharedClient;
}


#pragma mark - Requests Methods

- (NSURLSessionDataTask *)logingUser:(NSString *)user password:(NSString *)password completion:(void (^)(NSDictionary *results, NSError *error))completion {
    NSURLSessionDataTask *task = [self POST:[kBASE_URL stringByAppendingString:@"/sessions.json"]
                                 parameters:@{@"" : @"sessions.json"}
                  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                      [formData appendPartWithFormData:[user dataUsingEncoding:NSUTF8StringEncoding] name:@"session[email]"];
                      [formData appendPartWithFormData:[password dataUsingEncoding:NSUTF8StringEncoding] name:@"session[password]"];
                  }
                                    success:^(NSURLSessionDataTask *task, id responseObject) {
                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                        if (httpResponse.statusCode == 200) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                completion([self parseUser:responseObject], nil);
                                            });
                                        } else {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
                                                completion(nil, nil);
                                            });
                                        }
                                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        //NSLog(@"json:%@", [task ]);
                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                        if (httpResponse.statusCode == 422) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
                                                completion(nil, nil);
                                            });
                                        } else {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                NSLog(@"ERROR: %@", NSLocalizedString(@"Connection_Error", nil));
                                                completion(nil, error);
                                            });
                                        }
                                    }];
    return task;
}


- (NSURLSessionDataTask *)sendComment:(NSString *)comment idLogs:(NSInteger)idLogs completion:(void (^)(NSDictionary *results, NSError *error))completion {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"set_comment" forKey:@"request"];
    [parameters setValue:[FeedUserDefaults user] forKey:@"user"];
    [parameters setValue:[FeedUserDefaults token] forKey:@"token"];
    [parameters setValue:comment forKey:@"text"];

    NSURLSessionDataTask *task = [self GET:kBASE_URL
                                parameters:parameters
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               if ([[responseObject valueForKey:@"success"] boolValue]) {
                                                   NSLog(@"EVENT: %@", NSLocalizedString(@"Connection_Successful", nil));
                                                   completion(responseObject, nil);
                                               } else {
                                                   NSError *error = [NSError errorWithDomain:@"Invalid User Token" code:99 userInfo:nil];
                                                   if ([[responseObject valueForKey:@"error"] isEqualToString:error.domain]) {
                                                       NSLog(@"ERROR: %@", NSLocalizedString(@"TokenInvalid", nil));
                                                       completion(responseObject, error);
                                                   } else {
                                                       NSLog(@"ERROR: %@", [responseObject valueForKey:@"error"]);
                                                       completion(responseObject, nil);
                                                   }
                                               }
                                           });
                                       } else {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
                                               completion(nil, nil);
                                           });
                                       }
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           NSLog(@"ERROR: %@", NSLocalizedString(@"Connection_Error", nil));
                                           /*[DatabaseConexion saveLogRequest:@"set_comment"
                                                                       user:[FeedUserDefaults user]
                                                                      token:[FeedUserDefaults token]
                                                                       rate:0
                                                                     dishID:0
                                                                    comment:comment
                                                                      error:[error localizedDescription]
                                                                     status:0
                                                                 identifier:idLogs];*/
                                           completion(nil, error);
                                       });
                                   }];
    return task;
}


- (NSMutableURLRequest *)getURLRequestForPictureID:(NSString *)pictureID andType:(NSString *)type {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"get_image" forKey:@"request"];
    [parameters setValue:[FeedUserDefaults user] forKey:@"user"];
    [parameters setValue:[FeedUserDefaults token] forKey:@"token"];
    [parameters setValue:type forKey:@"type"];
    [parameters setValue:[NSNumber numberWithInteger:1] forKey:@"image"];
    [parameters setValue:pictureID forKey:@"id"];

    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET"
                                                                   URLString:kBASE_URL
                                                                  parameters:parameters
                                                                       error:nil];
    return request;
}



#pragma mark - Parsing Methods


- (NSDictionary *)parseUser:(id)response {
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];

    // Gets all the Staff from an specific team
    if (![[response objectForKey:@"user"] isKindOfClass:[NSNull class]]) {
        NSDictionary *userInfo = [response objectForKey:@"user"];
        User *user = [[User alloc] init];
        user.identifier = [[userInfo valueForKey:@"id"] integerValue];
        user.name = [userInfo valueForKey:@"name"];
        user.email = [userInfo valueForKey:@"email"];
        [results setValue:user forKey:@"user"];
    }

    [results setValue:[response valueForKey:@"token"] forKey:@"token"];
    [results setValue:[response valueForKey:@"success"] forKey:@"success"];

    return results;
}



//- (NSDictionary *)parseEmployees:(id)response {
//    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
//
//    // Gets all the Staff from an specific team
//    NSMutableArray *employeeArray = [[NSMutableArray alloc] init];
//    if (![[response objectForKey:@"users"] isKindOfClass:[NSNull class]]) {
//        for (NSDictionary *item in [response valueForKey:@"users"]) {
//            Employee *employeeItem = [[Employee alloc] init];
//            employeeItem.user = [item valueForKey:@"user"];
//            if ([item valueForKey:@"name"] != nil && ![[item valueForKey:@"name"] isKindOfClass:[NSNull class]]) {
//                NSString *name = [item valueForKey:@"name"];
//                NSRange range = [name rangeOfString:@", Vodafone"];
//                employeeItem.name = (range.location < name.length) ? [name substringToIndex:[name rangeOfString:@", Vodafone"].location]: name;
//            }
//            employeeItem.position = (NSString *)[item valueForKey:@"title"];
//            employeeItem.email = (NSString *)[item valueForKey:@"email"];
//            employeeItem.phoneNumber = (NSString *)[item valueForKey:@"telephone"];
//            if ([item objectForKey:@"manager"] != nil &&
//                ![[item objectForKey:@"manager"] isKindOfClass:[NSNull class]] &&
//                ![[item objectForKey:@"manager"] isEqualToString:@""]) {
//                [employeeItem.teams addObject:[item objectForKey:@"manager"]];
//            }
//            employeeItem.pictureID = [item valueForKey:@"image_id"];
//            employeeItem.lastUpdate = [Utility getDateFromString:[item valueForKey:@"lastupdate"] withFormat:kDATE_FORMAT];
//            NSString *picEncodedString = [item valueForKey:@"image"];
//            if (![picEncodedString isKindOfClass:[NSNull class]] && picEncodedString != nil && employeeItem.pictureID != nil) {
//                NSData *dataImage = [[NSData alloc] initWithBase64EncodedString:picEncodedString
//                                                                        options:NSDataBase64DecodingIgnoreUnknownCharacters];
//                employeeItem.picture = (dataImage != nil) ? [UIImage imageWithData:dataImage] : nil;
//            }
//            
//            [employeeArray addObject:employeeItem];
//        }
//    }
//
//    [results setValue:employeeArray forKey:@"staff"];
//    [results setValue:[response valueForKey:@"rows"] forKey:@"rows"];
//    [results setValue:[response valueForKey:@"deleted"] forKey:@"deleted"];
//    [results setValue:[response valueForKey:@"lastupdate"] forKey:@"lastUpdate"];
//    [results setValue:[response valueForKey:@"success"] forKey:@"success"];
//
//    return results;
//}



@end
