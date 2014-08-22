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

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, strong) NSNumber *capacity;
@property (nonatomic, strong) NSMutableArray *photo;
@property (nonatomic, strong) NSMutableArray *services;
@property (nonatomic, strong) UIImage *icon;

- (id)initWithIdentifier:(NSNumber *)aIdentifier
                    name:(NSString *)aName
                location:(NSString *)aLocation
                capacity:(NSNumber *)aCapacity
                   photo:(NSMutableArray *)anPhotos
                services:(NSMutableArray *)anServices;

@end
