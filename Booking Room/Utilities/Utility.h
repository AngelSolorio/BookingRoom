//
//  Utility.h
//  Booking Room
//
//  Created by Angel Solorio on 2/6/14.
//  Copyright (c) 2014 Angel Solorio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (NSString *)trimString:(NSString *)stringñ;

+ (float)getDeviceiOSVersion;
+ (CGSize)getScreenSize;
+ (UIInterfaceOrientation)getOrientation;

+ (UIImage *)getImageFromURLString:(NSString *)stringURL;
+ (UIImage *)getImageFrom64EncodedString:(NSString *)encodedString;
+ (UIImage *)getImageFromFileSystem:(NSString *)fileName;
+ (void)saveImageToFileSystem:(UIImage *)photo withFileName:(NSString *)fileName;
+ (BOOL)deleteFileFromFileSystemWithName:(NSString *)fileName;

+ (NSDate *)getDateFromString:(NSString *)stringDate withFormat:(NSString *)format;
+ (NSString *)getStringFromDate:(NSDate *)date withFormat:(NSString *)format;

+ (NSString *)getCurrentLanguageString;
+ (NSString *)getCurrentLanguageCode;
+ (NSInteger)getCurrentLanguageID;

+ (NSString *)getHttpStringFromString:(NSString *)urlString;

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length;


@end
