//
//  Utility.h
//  Booking Room
//
//  Created by Angel Solorio on 2/6/14.
//  Copyright (c) 2014 Angel Solorio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (NSString *)trimString:(NSString *)string;
+ (float)getDeviceiOSVersion;
+ (CGSize)getScreenSize;
+ (UIInterfaceOrientation)getOrientation;
+ (UIImage *)getScreenshot:(UIView *)view;

+ (UIImage *)getImageFromURLString:(NSString *)stringURL;
+ (UIImage *)getImageFrom64EncodedString:(NSString *)encodedString;
+ (UIImage *)getImageFromFileSystem:(NSString *)fileName;
+ (UIImage *)getImageFromFileSystem:(NSString *)fileName inFolder:(NSString *)directory;
+ (void)saveImageToFileSystem:(UIImage *)photo withFileName:(NSString *)fileName inFolder:(NSString*)directory;
+ (void)saveImageToFileSystem:(UIImage *)photo withFileName:(NSString *)fileName;
+ (BOOL)deleteFileFromFileSystemWithName:(NSString *)fileName;
+ (BOOL)deleteFileFromFileSystemWithName:(NSString *)fileName inFolder:(NSString*)directory;

+ (NSDate *)getDateFromString:(NSString *)stringDate withFormat:(NSString *)format;
+ (NSString *)getStringFromDate:(NSDate *)date withFormat:(NSString *)format;
+ (NSInteger)getNumberOfDaysFromMonth:(NSDate *)date;
+ (NSArray *)getArrayOfDaysFromMonth:(NSDate *)date;
+ (NSInteger)getDayNumberFromDate:(NSDate *)date;
+ (NSInteger)getMonthNumberFromDate:(NSDate *)date;
+ (NSInteger)getYearNumberFromDate:(NSDate *)date;

+ (NSString *)getCurrentLanguageString;
+ (NSString *)getCurrentLanguageCode;
+ (NSInteger)getCurrentLanguageID;

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length;

+ (NSString *)getHttpStringFromString:(NSString *)urlString;

@end
