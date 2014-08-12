//
//  BookingRoom.h
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import "Service.h"

@interface MeetingRoom : NSObject

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSMutableArray *photo;
@property (strong, nonatomic) NSMutableArray *services;

- (id)initWithIdentifier:(NSNumber *)aIdentifier
                    name:(NSString *)aName
                location:(NSString *)aLocation
                   photo:(NSMutableArray *)anPhotos
                services:(NSMutableArray *)anServices;

@end
