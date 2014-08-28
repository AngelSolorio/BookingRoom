//
//  BookingDetailsViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMStepsController.h"
#import "ActionSheetCalendarViewController.h"
#import "Utility.h"

@interface BookingDetailsViewController : UIViewController <UITextFieldDelegate, ActionSheetCalendarDelegate> {
    NSInteger optionSelected;
}

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *startDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;


- (IBAction)nextStep:(id)sender;
- (IBAction)showPicker:(id)sender;

@end
