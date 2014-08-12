//
//  Service.m
//  Booking Room
//
//  Created by Sandra Guzman on 11/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "Service.h"

@implementation Service

- (id)init {
    self = [self initWithIdentifier:0
                               name:@"Default"
                              value:0
                              photo:[[Photo alloc]init]];
    return self;
}


- (id)initWithIdentifier:(NSNumber *)aIdentifier
                    name:(NSString *)aName
                   value:(NSNumber *)aValue
                   photo:(Photo *)aPhoto {
    self = [super init];
    if(self) {
        self.identifier = aIdentifier;
        self.name = aName;
        self.value = aValue;
        self.photo = aPhoto;
    }
    return self;
}


@end
