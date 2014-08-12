//
//  Service.h
//  Booking Room
//
//  Created by Sandra Guzman on 11/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface Service : NSObject

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *value;
@property (strong, nonatomic) Photo *photo;

- (id)initWithIdentifier:(NSNumber *)aIdentifier
                    name:(NSString *)aName
                   value:(NSNumber *)aValue
                   photo:(Photo *)aPhoto;

@end
