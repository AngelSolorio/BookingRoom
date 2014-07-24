//
//  BookingRoom.m
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "MeetingRoom.h"

@implementation MeetingRoom

- (id)initWithTitle:(NSString *)title andDetails:(NSString *)details andIcon:(UIImage *)icon {
    self = [super init];
    if (self) {
        _title = title;
        _details = details;
        _icon = icon;
    }
    return self;
}

@end
