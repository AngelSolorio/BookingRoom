//
//  Booking.m
//  Booking Room
//
//  Created by Sandra Guzman on 06/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "Booking.h"

@implementation Booking

- (id)initWithTitle:(NSString *)title andDate:(NSDate *)date andHour:(NSDate *)hour andPhoto:(UIImage *)photo andPriority:(NSInteger)priority {
    self = [super init];
    if (self) {
        _title = title;
        _date = date;
        _hour = hour;
        _photo = photo;
        _priority = priority;
    }
    return self;
}

@end
