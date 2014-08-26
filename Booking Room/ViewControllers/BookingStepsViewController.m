//
//  RMNavStepsViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "BookingStepsViewController.h"

@interface BookingStepsViewController ()

@end

@implementation BookingStepsViewController

#pragma mark - Init and Dealloc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stepsBar.hideCancelButton = YES;
}

#pragma mark - Actions
- (void)finishedAllSteps {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)canceled {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)stepViewControllers {
    UIViewController *firstStep = [self.storyboard instantiateViewControllerWithIdentifier:@"Step1"];
    firstStep.step.title = NSLocalizedString(@"BookingSteps_Details", nil);
    
    UIViewController *secondStep = [self.storyboard instantiateViewControllerWithIdentifier:@"Step2"];
    secondStep.step.title = NSLocalizedString(@"BookingSteps_Assistants", nil);

    UIViewController *thirdStep = [self.storyboard instantiateViewControllerWithIdentifier:@"Step3"];
    thirdStep.step.title = NSLocalizedString(@"BookingSteps_Rooms", nil);
    
    return @[firstStep, secondStep, thirdStep];
}

- (IBAction)backButtonTouch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
