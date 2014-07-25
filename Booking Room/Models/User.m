//
//  User.m
//  Booking Room
//
//  Created by Angel Solorio on 7/25/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithIdentifier:(NSInteger)identifier name:(NSString *)name email:(NSString *)email {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _name = name;
        _email = email;
    }

    return self;
}


- (void)setName:(NSString *)name {
    if (_name != name && ![name isKindOfClass:[NSNull class]]) {
        _name = [Utility trimString:name];
    }
}


- (void)setEmail:(NSString *)email {
    if (_email != email && ![email isKindOfClass:[NSNull class]]) {
        _email = [Utility trimString:email];
    }
}


@end
