//
//  FeedUserDefaults.m
//  Booking Room
//
//  Created by Angel Solorio on 2/27/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.


#import "FeedUserDefaults.h"
#import "TypeDefs.h"


@implementation FeedUserDefaults

+ (NSString *)user {
    NSString *stringValue = [[NSUserDefaults standardUserDefaults] objectForKey:FEEDUSERDEFAULTS_USER];
    NSString *returnValue = FEEDUSERDEFAULTS_DEFAULTUSER;
    
    if (!stringValue) {
        [[NSUserDefaults standardUserDefaults] setObject:returnValue forKey:FEEDUSERDEFAULTS_USER];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        returnValue = stringValue;
    }
    
    return returnValue;
}


+ (void)setUser:(NSString*)user {
    [[NSUserDefaults standardUserDefaults] setObject:user forKey:FEEDUSERDEFAULTS_USER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *)name {
    NSString *stringValue = [[NSUserDefaults standardUserDefaults] objectForKey:FEEDUSERDEFAULTS_NAME];
    NSString *returnValue = FEEDUSERDEFAULTS_DEFAULTNAME;

    if (!stringValue) {
        [[NSUserDefaults standardUserDefaults] setObject:returnValue forKey:FEEDUSERDEFAULTS_NAME];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        returnValue = stringValue;
    }

    return returnValue;
}


+ (void)setName:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:FEEDUSERDEFAULTS_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *)nameString {
    NSString *stringValue = [[NSUserDefaults standardUserDefaults] objectForKey:FEEDUSERDEFAULTS_NAMESTRING];
    NSString *returnValue = FEEDUSERDEFAULTS_DEFAULTNAMESTRING;

    if (!stringValue) {
        [[NSUserDefaults standardUserDefaults] setObject:returnValue forKey:FEEDUSERDEFAULTS_NAMESTRING];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        returnValue = stringValue;
    }

    return returnValue;
}


+ (void)setNameString:(NSString *)nameString {
    [[NSUserDefaults standardUserDefaults] setObject:nameString forKey:FEEDUSERDEFAULTS_NAMESTRING];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *)password {
    NSString *stringValue = [[NSUserDefaults standardUserDefaults] objectForKey:FEEDUSERDEFAULTS_PASSWORD];
    NSString *returnValue = FEEDUSERDEFAULTS_DEFAULTPASSWORD;
    
    if (!stringValue) {
        [[NSUserDefaults standardUserDefaults] setObject:returnValue forKey:FEEDUSERDEFAULTS_PASSWORD];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        returnValue = stringValue;
    }
    
    return returnValue;
}


+ (void)setPassword:(NSString *)pwd {
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:FEEDUSERDEFAULTS_PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *)pin {
    NSString *stringValue = [[NSUserDefaults standardUserDefaults] objectForKey:FEEDUSERDEFAULTS_PIN];
    NSString *returnValue = FEEDUSERDEFAULTS_DEFAULTPIN;
    
    if (!stringValue) {
        [[NSUserDefaults standardUserDefaults] setObject:returnValue forKey:FEEDUSERDEFAULTS_PIN];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        returnValue = stringValue;
    }
    
    return returnValue;
}


+ (void)setPin:(NSString *)pin {
    [[NSUserDefaults standardUserDefaults] setObject:pin forKey:FEEDUSERDEFAULTS_PIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL)activePin {
    NSNumber *numberValue = [[NSUserDefaults standardUserDefaults] objectForKey:FEEDUSERDEFAULTS_ACTIVEPIN];
    BOOL returnValue = (BOOL)FEEDUSERDEFAULTS_DEFAULTACTIVEPIN;
    
    if (!numberValue) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:returnValue] forKey:FEEDUSERDEFAULTS_ACTIVEPIN];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        returnValue = [numberValue boolValue];
    }
    
    return returnValue;
}


+ (void)setActivePin:(BOOL)activePin {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:activePin] forKey:FEEDUSERDEFAULTS_ACTIVEPIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSDate *)staffLastUpdate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:TYPEDEFS_FORMATDATE_YEAR_MONTH_DAY];
    NSDate *dateValue = [[NSUserDefaults standardUserDefaults] objectForKey:FEEDUSERDEFAULTS_STAFFLASTUPDATE];
    
    if (!dateValue) {
         return nil;
    } else {
        return dateValue;
    }
}


+ (void)setStaffLastUpdate:(NSDate *)date {
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:FEEDUSERDEFAULTS_STAFFLASTUPDATE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *)token {
    NSString *stringValue = [[NSUserDefaults standardUserDefaults] objectForKey:FEEDUSERDEFAULTS_TOKEN];
    NSString *returnValue = FEEDUSERDEFAULTS_DEFAULTTOKEN;

    if (!stringValue) {
        [[NSUserDefaults standardUserDefaults] setObject:returnValue forKey:FEEDUSERDEFAULTS_TOKEN];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        returnValue = stringValue;
    }

    return returnValue;
}


+ (void)setToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:FEEDUSERDEFAULTS_TOKEN];
}


+ (NSString *)language {
    NSString *stringValue = [[NSUserDefaults standardUserDefaults] objectForKey:FEEDUSERDEFAULTS_LANGUAGE];
    NSString *returnValue = FEEDUSERDEFAULTS_DEFAULTLANGUAGE;

    if (!stringValue) {
        [[NSUserDefaults standardUserDefaults] setObject:returnValue forKey:FEEDUSERDEFAULTS_LANGUAGE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        returnValue = stringValue;
    }

    return returnValue;
}


+ (void)setLanguage:(NSString *)language {
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:FEEDUSERDEFAULTS_LANGUAGE];
}


+ (BOOL)reloginAvailable {
    NSNumber *numberValue = [[NSUserDefaults standardUserDefaults] objectForKey:FEEDUSERDEFAULTS_RELOGIN];
    BOOL returnValue = (BOOL)FEEDUSERDEFAULTS_DEFAULTRELOGIN;

    if (!numberValue) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:returnValue] forKey:FEEDUSERDEFAULTS_RELOGIN];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        returnValue = [numberValue boolValue];
    }

    return returnValue;
}


+ (void)setReloginAvailable:(BOOL)relogin {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:relogin] forKey:FEEDUSERDEFAULTS_RELOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
