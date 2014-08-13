//
//  Photo.m
//  Booking Room
//
//  Created by Sandra Guzman on 11/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (id)init {
    self = [self initWithIdentifier:0
                               name:@"Default"
                              image:[UIImage imageNamed:@"ImageContact"]];
    return self;
}


- (id)initWithIdentifier:(NSNumber *)aIdentifier
                    name:(NSString *)aName
                   image:(UIImage *)aImage {
    self = [super init];
    if(self) {
        self.identifier = aIdentifier;
        self.name = aName;
        self.image = aImage;
    }
    return self;
}

- (id)initWithImage:(UIImage *)aImage {
    self = [super init];
    if(self) {
        self.image = aImage;
    }
    return self;
}

@end
