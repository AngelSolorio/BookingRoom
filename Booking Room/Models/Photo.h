//
//  Photo.h
//  Booking Room
//
//  Created by Sandra Guzman on 11/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *url;

- (id)initWithIdentifier:(NSNumber *)aIdentifier
                    name:(NSString *)aName
                     url:(NSString *)aUrl;

- (id)initWithImage:(UIImage *)aImage;

@end
