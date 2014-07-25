//
//  User.h
//  Booking Room
//
//  Created by Angel Solorio on 7/25/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utility.h"

@interface User : NSObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, strong) UIImage *photo;

- (id)initWithIdentifier:(NSInteger)identifier name:(NSString *)name email:(NSString *)email;

@end
