//
//  Person.m
//  Booking Room
//
//  Created by Sandra Guzman on 11/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)init {
    self = [self initWithIdentifier:0
                               name:@"Default"
                              email:@"Default"
                              photo:[[Photo alloc]init]
                         department:@"Default"
                            company:@"Default"
                           position:@"Default"
                                car:[[Car alloc]init]];
    return self;
}


- (id)initWithIdentifier:(NSNumber *)aIdentifier
                    name:(NSString *)aName
                   email:(NSString *)aEmail
                   photo:(Photo *)aPhoto
              department:(NSString *)aDepartment
                 company:(NSString *)aCompany
                position:(NSString *)aPosition
                     car:(Car *)aCar {
    self = [super init];
    if(self) {
        self.identifier = aIdentifier;
        self.name = aName;
        self.email = aEmail;
        self.photo = aPhoto;
        self.department = aDepartment;
        self.company = aCompany;
        self.position = aPosition;
        self.car = aCar;
    }
    return self;
}

@end
