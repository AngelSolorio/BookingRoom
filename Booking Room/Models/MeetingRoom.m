//
//  BookingRoom.m
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "MeetingRoom.h"

@implementation MeetingRoom

- (id)init {
    self = [self initWithIdentifier:0
                               name:@"Default"
                           location:@"Default"
                              photo:[[NSMutableArray alloc]initWithObjects: [[Photo alloc]init], nil]
                           services:[[NSMutableArray alloc]initWithObjects: [[Service alloc]init], nil]];
    return self;
}


- (id)initWithIdentifier:(NSNumber *)aIdentifier
                    name:(NSString *)aName
                location:(NSString *)aLocation
                   photo:(NSMutableArray *)anPhotos
                services:(NSMutableArray *)anServices {
    self = [super init];
    if(self) {
        self.identifier = aIdentifier;
        self.name = aName;
        self.location = aLocation;
        self.photo = anPhotos;
        self.services = anServices;
    }
    return self;
}

@end
