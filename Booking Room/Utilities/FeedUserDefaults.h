//
//  FeedUserDefaults.h
//  Booking Room
//
//  Created by Angel Solorio on 2/27/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.


#import <Foundation/Foundation.h>

#define FEEDUSERDEFAULTS_USER @"user"
#define FEEDUSERDEFAULTS_NAME @"name"
#define FEEDUSERDEFAULTS_NAMESTRING @"nameString"
#define FEEDUSERDEFAULTS_PASSWORD @"password"
#define FEEDUSERDEFAULTS_PIN @"pin"
#define FEEDUSERDEFAULTS_ACTIVEPIN @"activePin"
#define FEEDUSERDEFAULTS_STAFFLASTUPDATE @"staffLastUpdate"
#define FEEDUSERDEFAULTS_TOKEN @"token"
#define FEEDUSERDEFAULTS_LANGUAGE @"language"
#define FEEDUSERDEFAULTS_RELOGIN @"relogin"

#define FEEDUSERDEFAULTS_DEFAULTUSER @""
#define FEEDUSERDEFAULTS_DEFAULTNAME @""
#define FEEDUSERDEFAULTS_DEFAULTNAMESTRING @""
#define FEEDUSERDEFAULTS_DEFAULTPASSWORD @""
#define FEEDUSERDEFAULTS_DEFAULTPIN @""
#define FEEDUSERDEFAULTS_DEFAULTACTIVEPIN @""
#define FEEDUSERDEFAULTS_DEFAULTTOKEN @""
#define FEEDUSERDEFAULTS_DEFAULTLANGUAGE @""
#define FEEDUSERDEFAULTS_DEFAULTRELOGIN @""


//  Class with static methods for the control of NSUserDefaults associted with the App
@interface FeedUserDefaults : NSObject

+ (NSString *)user;
+ (void)setUser:(NSString *)user;

+ (NSString *)name;
+ (void)setName:(NSString *)name;

+ (NSString *)nameString;
+ (void)setNameString:(NSString *)nameString;

+ (NSString *)password;
+ (void)setPassword:(NSString *)pwd;

+ (NSString *)pin;
+ (void)setPin:(NSString *)pin;

+ (BOOL)activePin;
+ (void)setActivePin:(BOOL)activePin;

+ (NSDate *)staffLastUpdate;
+ (void)setStaffLastUpdate:(NSDate *)date;

+ (NSString *)token;
+ (void)setToken:(NSString *)token;

+ (NSString *)language;
+ (void)setLanguage:(NSString *)language;

+ (BOOL)reloginAvailable;
+ (void)setReloginAvailable:(BOOL)relogin;


@end
