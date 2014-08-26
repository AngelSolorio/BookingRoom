//
//  BookingDetailsViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMStepsController.h"

@interface BookingDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

- (IBAction)nextStep:(id)sender;

@end
