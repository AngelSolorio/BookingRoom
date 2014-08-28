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
    _titleTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _titleTextField.layer.borderWidth = 1.0f;
    _titleTextField.delegate = self;
    
    _startDateTextField.borderStyle = UITextBorderStyleLine;
    _startDateTextField.layer.cornerRadius = 8.0f;
    _startDateTextField.layer.masksToBounds = YES;
    _startDateTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _startDateTextField.layer.borderWidth = 1.0f;
    
    _endDateTextField.borderStyle = UITextBorderStyleLine;
    _endDateTextField.layer.cornerRadius = 8.0f;
    _endDateTextField.layer.masksToBounds = YES;
    _endDateTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _endDateTextField.layer.borderWidth = 1.0f;
    
    _dateTextField.borderStyle = UITextBorderStyleLine;
    _dateTextField.layer.cornerRadius = 8.0f;
    _dateTextField.layer.masksToBounds = YES;
    _dateTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _dateTextField.layer.borderWidth = 1.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextStep:(id)sender {
    [self.stepsController showNextStep];
}

- (IBAction)showPicker:(id)sender {
    [self.view endEditing:YES];
    UIButton *btn = (UIButton *)sender;
    optionSelected = btn.tag;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ActionSheetCalendarViewController *modalVC = [storyboard instantiateViewControllerWithIdentifier:@"ActionSheetCalendarView"];
    modalVC.delegate = self;
    modalVC.modalPresentationStyle = UIModalPresentationFormSheet;
    modalVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:modalVC animated:NO completion:NULL];
}


#pragma mark - ActionSheetCalendarDelegate Methods

-(void)setSelectedDatePicker:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm"];
    NSString *theTime = [timeFormat stringFromDate:date];
    NSString *theDate = [dateFormat stringFromDate:date];
    
    if (optionSelected == 5) {
         _startDateTextField.text = theTime;
    } else if (optionSelected == 6) {
        _endDateTextField.text = theTime;
    }
    
    _dateTextField.text = theDate;
    optionSelected = 0;
}


#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
