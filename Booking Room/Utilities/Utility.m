//
//  Utility.m
//  Booking Room
//
//  Created by Angel Solorio on 2/6/14.
//  Copyright (c) 2014 Angel Solorio. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSString *)trimString:(NSString *)string {
    return [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}


#pragma mark - Device Methods

// Gets the iOS version running on this device
+ (float)getDeviceiOSVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

// Gets the current screen size
+ (CGSize)getScreenSize {
    CGRect rectDevice = [[UIScreen mainScreen] bounds];
    return rectDevice.size;
}

// Gets the current orientation
+ (UIInterfaceOrientation)getOrientation {
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    return interfaceOrientation;
}

// Get an screenshot
+ (UIImage *)getScreenshot:(UIView *)view {
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return viewImage;
}


#pragma mark - UIImage Methods

// Gets a UIImage from a URL
+ (UIImage *)getImageFromURLString:(NSString *)stringURL {
    if (stringURL != nil || [stringURL length] > 0) {
        NSURL *url = [NSURL URLWithString:stringURL];
        NSData *dataImage = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *photo = [[UIImage alloc] initWithData:dataImage];
        return photo;
    }
    return  nil;
}

// Gets a UIImage from an encoded string
+ (UIImage *)getImageFrom64EncodedString:(NSString *)encodedString {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:encodedString
                                                       options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

// Saves an image to the File System
+ (UIImage *)getImageFromFileSystem:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;

    return [UIImage imageWithContentsOfFile:[basePath stringByAppendingPathComponent:fileName]];
}

// Saves an image to the File System
+ (void)saveImageToFileSystem:(UIImage *)photo withFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;

    UIImage *imageToSave = photo;
    NSData *binaryImageData = UIImagePNGRepresentation(imageToSave);

    [binaryImageData writeToFile:[basePath stringByAppendingPathComponent:fileName] atomically:YES];
}

// Deletes an image to the File System
+ (BOOL)deleteFileFromFileSystemWithName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;

    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;

    return [manager removeItemAtPath:[basePath stringByAppendingPathComponent:fileName] error:&error];
}

// Deletes an image to the File System
+ (BOOL)deleteFileFromFileSystemWithName:(NSString *)fileName inFolder:(NSString *)directory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *dataPath = [basePath stringByAppendingPathComponent:directory];

    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;

    return [manager removeItemAtPath:[dataPath stringByAppendingPathComponent:fileName] error:&error];
}

// Saves an image to the File System
+ (UIImage *)getImageFromFileSystem:(NSString *)fileName inFolder:(NSString *)directory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *dataPath = [basePath stringByAppendingPathComponent:directory];

    return [UIImage imageWithContentsOfFile:[dataPath stringByAppendingPathComponent:fileName]];
}

// Saves an image to the File System
+ (void)saveImageToFileSystem:(UIImage *)photo withFileName:(NSString *)fileName inFolder:(NSString*)directory {
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths firstObject] : nil;
    NSString *dataPath = [basePath stringByAppendingPathComponent:directory];
    if (![filemgr fileExistsAtPath:dataPath]){
        [filemgr createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
    }

    UIImage *imageToSave = photo;
    NSData *binaryImageData = UIImagePNGRepresentation(imageToSave);

    [binaryImageData writeToFile:[dataPath stringByAppendingPathComponent:fileName] atomically:YES];
}


#pragma mark - Date Methods

// Gets a NSDate value from a NSString
+ (NSDate *)getDateFromString:(NSString *)stringDate withFormat:(NSString *)format {
    if (![stringDate isKindOfClass:[NSNull class]] && stringDate != nil) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:format];
        NSDate *myDate = [dateFormat dateFromString:stringDate];
        return myDate;
    }
    return nil;
}

// Gets a  NSString from a NSDate value
+ (NSString *)getStringFromDate:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];

    NSString *strinDate = [dateFormat stringFromDate:date];

    return strinDate;
}

// Gets the number of days from an specific month
+ (NSInteger)getNumberOfDaysFromMonth:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    return rng.length;
}

// Gets an array with the days from an specific month
+ (NSArray *)getArrayOfDaysFromMonth:(NSDate *)date {
    NSDate *today = date;
    NSCalendar *cal = [NSCalendar currentCalendar];

    NSMutableArray *datesThisMonth = [NSMutableArray array];
    NSRange rangeOfDaysThisMonth = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:today];

    NSDateComponents *components = [cal components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSEraCalendarUnit) fromDate:today];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];

    for (NSInteger i = rangeOfDaysThisMonth.location; i < NSMaxRange(rangeOfDaysThisMonth); ++i) {
        [components setDay:i];
        NSDate *dayInMonth = [cal dateFromComponents:components];
        [datesThisMonth addObject:dayInMonth];
    }

    NSMutableArray *daysFormatted = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"E d"];
    NSLocale *currentLocale;
    if ([[Utility getCurrentLanguageCode] isEqualToString:@"en"]) {
        currentLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    } else {
        currentLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_MX"];
    }
    [formatter setLocale:currentLocale];
    for (NSDate *date in datesThisMonth) {
        NSString *stringDate = [formatter stringFromDate:date];
        [daysFormatted addObject:stringDate];
        NSLog(@"Date Formatted: %@", stringDate);
    }

    return daysFormatted;
}

+ (NSInteger)getDayNumberFromDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];

    return [components day];
}


+ (NSInteger)getMonthNumberFromDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];

    return [components month];
}


+ (NSInteger)getYearNumberFromDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];

    return [components year];
}



#pragma mark - Translations Methods

// Gets a NSString with the current language name of the App
+ (NSString *)getCurrentLanguageString {
    NSArray *languages = [[NSArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]];
    return (languages.count > 0) ? NSLocalizedString([languages firstObject], nil) : @"";
}

// Gets a NSString with the current language code of the App
+ (NSString *)getCurrentLanguageCode {
    NSArray *languages = [[NSArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]];
    return (languages.count > 0) ? [languages firstObject] : @"";
}

// Gets an NSInteger with the current language identifier of the App
+ (NSInteger)getCurrentLanguageID {
    NSArray *languages = [[NSArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]];
    if ([[languages firstObject] isEqualToString:@"en"]) {
        return 2;
    } else {
        return 1;
    }
}


#pragma mark - Colors Methods

+ (UIColor *)colorWithHexString: (NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}


+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}


#pragma mark - Other Methods

// Gets an URL NSString with the corresponding HTPP:// or HTPP:// initial substring
+ (NSString *)getHttpStringFromString:(NSString *)urlString {
    if ([[urlString substringToIndex:7].lowercaseString isEqualToString:@"http://"] || [[urlString substringToIndex:8].lowercaseString isEqualToString:@"https://"]) {
        return urlString;
    } else {
        return [@"http://" stringByAppendingString:(urlString != nil) ? urlString : @""];
    }
}


@end
