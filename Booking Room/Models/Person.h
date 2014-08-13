//
//  Person.h
//  Booking Room
//
//  Created by Sandra Guzman on 11/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import "Car.h"

@interface Person : NSObject

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) Photo *photo;
@property (strong, nonatomic) NSString *department;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) Car *car;

- (id)initWithIdentifier:(NSNumber *)aIdentifier
                    name:(NSString *)aName
                   email:(NSString *)aEmail
                   photo:(Photo *)aPhoto
              department:(NSString *)aDepartment
                 company:(NSString *)aCompany
                position:(NSString *)aPosition
                     car:(Car *)aCar;

@end
