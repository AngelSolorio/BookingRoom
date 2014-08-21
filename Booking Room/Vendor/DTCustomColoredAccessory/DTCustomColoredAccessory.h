//
//  DTCustomColoredAccessory.h
//  Booking Room
//
//  Created by Sandra Guzman on 21/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTCustomColoredAccessory : UIControl {
    UIColor *_accessoryColor;
    UIColor *_highlightedColor;
}

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;

+ (DTCustomColoredAccessory *)accessoryWithColor:(UIColor *)color;

@end
