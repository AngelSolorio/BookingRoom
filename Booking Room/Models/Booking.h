//
//  Booking.h
//  Booking Room
//
//  Created by Sandra Guzman on 06/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeetingRoom.h"

@interface Booking : NSObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSDate *hour;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, assign) MeetingRoom *meetingRoom;
@property (nonatomic, strong) UIImage *photo;

- (id)initWithTitle:(NSString *)title andDate:(NSDate *)date andHour:(NSDate *)hour andPhoto:(UIImage *)photo andPriority:(NSInteger)priority;

@end
