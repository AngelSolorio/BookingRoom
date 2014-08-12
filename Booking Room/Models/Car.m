//
//  Car.m
//  Booking Room
//
//  Created by Sandra Guzman on 11/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "Car.h"

@implementation Car

- (id)init {
    self = [self initWithIdentifier:0
                              model:@"Default"
                              plate:@"Default"
                              color:@"Default"
                              brand:@"Default"];
    return self;
}


- (id)initWithIdentifier:(NSNumber *)aIdentifier
                   model:(NSString *)aModel
                   plate:(NSString *)aPlate
                   color:(NSString *)aColor
                   brand:(NSString *)aBrand {
    self = [super init];
    if(self) {
        self.identifier = aIdentifier;
        self.model = aModel;
        self.plate = aPlate;
        self.color = aColor;
        self.brand = aBrand;
    }
    return self;
}

@end
