//
//  LoginViewController.m
//  Booking Room
//
//  Created by Angel Solorio on 7/22/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "LoginViewController.h"
#import "TypeDefs.h"
#import <QuartzCore/QuartzCore.h>

#define OFFSET 70


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _userTextField.delegate = self;
    _passwordTextField.delegate = self;

    _loginButton.enabled = NO;

    // Register for Keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // Hides the Navigation Bar
    [self.navigationController setNavigationBarHidden:YES];

    // Set the title's controls
    _userTextField.placeholder = NSLocalizedString(@"Logup_UserField", nil);
    _passwordTextField.placeholder = NSLocalizedString(@"Logup_PasswordField", nil);
    _userTextField.text = ([FeedUserDefaults user].length > 0)? [FeedUserDefaults user] :@"";

    [_loginButton setTitle:NSLocalizedString(@"Logup_LoginButton", nil) forState:UIControlStateNormal];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _userTextField.text = @"";
    _passwordTextField.text = @"";
    [_passwordTextField becomeFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction Methods

- (IBAction)hideKeyboard:(id)sender {
    [_userTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (IBAction)loginUser:(id)sender {
    _loginButton.enabled = NO;

    // Hides the keyboard
    [self hideKeyboard:self];
}


#pragma mark - PinPadPasswordProtocol Methods

- (BOOL)checkPin:(NSString *)pin {
    BOOL result = NO;
    if ([pin isEqualToString:@"1234"]) {
        result = YES;
    }

    return result;
}


- (NSInteger)pinLenght {
    return 4;
}


- (void)newPinSet:(NSString *)newPin inViewController:(UIViewController *)pvc {
    // Dismiss the PIN View Controller and show the home view
    [pvc dismissViewControllerAnimated:NO completion:^{
        // Shows the home view
        //[self performSegueWithIdentifier:@"loginToHome" sender:self];
    }];

    // Stores the new PIN set and USER
    [FeedUserDefaults setPin:newPin];
}


#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:_userTextField] && ![textField.text isEqualToString:@""]) {
        [_passwordTextField becomeFirstResponder];
    } else if([textField isEqual:_passwordTextField]) {
        [self loginUser:_loginButton];
    }

    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_userTextField.text.length > 0 && _passwordTextField.text.length > 0) {
        _loginButton.enabled = YES;
    }
    return YES;
}


#pragma mark - Keyboard Notifications Methods

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint pointToSearch = CGPointMake(_loginButton.frame.origin.x, _loginButton.frame.origin.y + _loginButton.frame.size.height);

    if (!CGRectContainsPoint(aRect, pointToSearch) ) {
        // Moves controls up
        _userTextField.frame = CGRectMake(_userTextField.frame.origin.x, _userTextField.frame.origin.y - OFFSET, _userTextField.frame.size.width, _userTextField.frame.size.height);
        _passwordTextField.frame = CGRectMake(_passwordTextField.frame.origin.x, _passwordTextField.frame.origin.y - OFFSET, _passwordTextField.frame.size.width, _passwordTextField.frame.size.height);
        _loginButton.frame = CGRectMake(_loginButton.frame.origin.x, _loginButton.frame.origin.y - OFFSET, _loginButton.frame.size.width, _loginButton.frame.size.height);
        //_logoView.frame = CGRectMake(_logoView.frame.origin.x, _logoView.frame.origin.y - 25, _logoView.frame.size.width, _logoView.frame.size.height);
    }
}


// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint pointToSearch = CGPointMake(_loginButton.frame.origin.x, _loginButton.frame.origin.y + _loginButton.frame.size.height);

    if (!CGRectContainsPoint(aRect, pointToSearch) ) {
        // Moves contolrs down
        _userTextField.frame = CGRectMake(_userTextField.frame.origin.x, _userTextField.frame.origin.y + OFFSET, _userTextField.frame.size.width, _userTextField.frame.size.height);
        _passwordTextField.frame = CGRectMake(_passwordTextField.frame.origin.x, _passwordTextField.frame.origin.y + OFFSET, _passwordTextField.frame.size.width, _passwordTextField.frame.size.height);
        _loginButton.frame = CGRectMake(_loginButton.frame.origin.x, _loginButton.frame.origin.y + OFFSET, _loginButton.frame.size.width, _loginButton.frame.size.height);
        //_logoView.frame = CGRectMake(_logoView.frame.origin.x, _logoView.frame.origin.y + 25, _logoView.frame.size.width, _logoView.frame.size.height);
    }
}


@end