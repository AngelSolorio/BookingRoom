//
//  RMNavStepsViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMStepsController.h"
#import "RMStepsBar.h"
#import "RMStep.h"

@interface BookingStepsViewController : RMStepsController

@property (nonatomic, strong, readonly) RMStepsBar *stepsBar;

- (IBAction)backButtonTouch:(id)sender;

@end
