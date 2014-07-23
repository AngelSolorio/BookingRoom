//
//  MenuItem.h
//  Palacio De Hierro
//
//  Created by Angel Solorio on 5/29/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *icon;

- (id)initWithTitle:(NSString *)title andIcon:(UIImage *)icon;

@end
