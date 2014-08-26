//
//  BookingDetailsViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "BookingDetailsViewController.h"

@interface BookingDetailsViewController ()

@end

@implementation BookingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Customize the UITextField's
    _titleTextField.borderStyle = UITextBorderStyleLine;
    _titleTextField.layer.cornerRadius = 8.0f;
    _titleTextField.layer.masksToBounds = YES;
    _titleTextField.layer.borderColor = [[UIColor whiteColor] CGColor];
    _titleTextField.layer.borderWidth = 1.0f;
    //[_titleTextField setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextStep:(id)sender {
    [self.stepsController showNextStep];
}


#pragma mark - UIInterfaceOrientation Methods

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
