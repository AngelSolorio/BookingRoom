//
//  MenuItem.m
//  Palacio De Hierro
//
//  Created by Angel Solorio on 5/29/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

- (id)initWithTitle:(NSString *)title andIcon:(UIImage *)icon {
    self = [super init];
    if (self) {
        _title = title;
        _icon = icon;
    }

    return self;
}

@end
