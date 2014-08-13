//
//  Car.h
//  Booking Room
//
//  Created by Sandra Guzman on 11/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *model;
@property (strong, nonatomic) NSString *plate;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *brand;

- (id)initWithIdentifier:(NSNumber *)aIdentifier
                   model:(NSString *)aModel
                   plate:(NSString *)aPlate
                   color:(NSString *)aColor
                   brand:(NSString *)aBrand;

@end
