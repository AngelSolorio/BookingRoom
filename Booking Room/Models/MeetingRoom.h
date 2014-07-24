//
//  BookingRoom.h
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeetingRoom : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *details;
@property (nonatomic, strong) UIImage *icon;

- (id)initWithTitle:(NSString *)title andDetails:(NSString *)details andIcon:(UIImage *)icon;

@end
