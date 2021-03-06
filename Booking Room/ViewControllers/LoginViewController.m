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

    // Customize the UITextField's
    _userTextField.borderStyle = UITextBorderStyleLine;
    _userTextField.layer.cornerRadius = 8.0f;
    _userTextField.layer.masksToBounds = YES;
    _userTextField.layer.borderColor = [[UIColor whiteColor] CGColor];
    _userTextField.layer.borderWidth = 1.0f;
    [_userTextField setDelegate:self];

    _passwordTextField.borderStyle = UITextBorderStyleLine;
    _passwordTextField.layer.cornerRadius = 8.0f;
    _passwordTextField.layer.masksToBounds = YES;
    _passwordTextField.layer.borderColor = [[UIColor whiteColor] CGColor];
    _passwordTextField.layer.borderWidth = 1.0f;
    [_passwordTextField setDelegate:self];

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
    _userTextField.placeholder = NSLocalizedString(@"Login_UserField", nil);
    _passwordTextField.placeholder = NSLocalizedString(@"Login_PasswordField", nil);
    _userTextField.text = ([FeedUserDefaults user].length > 0)? [FeedUserDefaults user] :@"";
    [_loginButton setTitle:NSLocalizedString(@"Login_LoginButton", nil) forState:UIControlStateNormal];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _userTextField.text = @"";
    _passwordTextField.text = @"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - IBAction Methods

- (IBAction)hideKeyboard:(id)sender {
    [_userTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}


- (IBAction)loginUser:(id)sender {
    _loginButton.enabled = NO;

    // Hides the keyboard
    [self hideKeyboard:self];

    // Creates a progress control
    progressView = [MRProgressOverlayView showOverlayAddedTo:self.view
                                                       title:NSLocalizedString(@"RefreshControl_Connecting", nil)
                                                        mode:MRProgressOverlayViewModeIndeterminate
                                                    animated:YES];
    progressView.tintColor = [UIColor colorWithRed:95/255. green:186/255. blue:89/255. alpha:1.0];

    // ---- Requests the login to the Web Service using the AFNetworking Framework ----
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    [[WebService sharedClient] logingUser:_userTextField.text
                                 password:_passwordTextField.text
                               completion:^(NSDictionary *results, NSError *error) {
                                   // Dismiss the progress indicator
                                   [progressView dismiss:YES];

                                   // Stops the activity network indicator
                                   [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                                   [self getLoginResults:results error:error];
                               }];
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
    // Shows the home view
    [self performSegueWithIdentifier:@"loginToRoot" sender:self];

    // Dismiss the PIN View Controller and show the home view
    [pvc dismissViewControllerAnimated:YES completion:^{

    }];

    // Stores the new PIN set
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
        _logoImageView.frame = CGRectMake(_logoImageView.frame.origin.x, _logoImageView.frame.origin.y - OFFSET, _logoImageView.frame.size.width, _logoImageView.frame.size.height);
        _appLabel.frame = CGRectMake(_appLabel.frame.origin.x, _appLabel.frame.origin.y - OFFSET, _appLabel.frame.size.width, _appLabel.frame.size.height);
        _userTextField.frame = CGRectMake(_userTextField.frame.origin.x, _userTextField.frame.origin.y - OFFSET, _userTextField.frame.size.width, _userTextField.frame.size.height);
        _passwordTextField.frame = CGRectMake(_passwordTextField.frame.origin.x, _passwordTextField.frame.origin.y - OFFSET, _passwordTextField.frame.size.width, _passwordTextField.frame.size.height);
        _loginButton.frame = CGRectMake(_loginButton.frame.origin.x, _loginButton.frame.origin.y - OFFSET, _loginButton.frame.size.width, _loginButton.frame.size.height);
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
        _logoImageView.frame = CGRectMake(_logoImageView.frame.origin.x, _logoImageView.frame.origin.y + OFFSET, _logoImageView.frame.size.width, _logoImageView.frame.size.height);
        _appLabel.frame = CGRectMake(_appLabel.frame.origin.x, _appLabel.frame.origin.y + OFFSET, _appLabel.frame.size.width, _appLabel.frame.size.height);
        _userTextField.frame = CGRectMake(_userTextField.frame.origin.x, _userTextField.frame.origin.y + OFFSET, _userTextField.frame.size.width, _userTextField.frame.size.height);
        _passwordTextField.frame = CGRectMake(_passwordTextField.frame.origin.x, _passwordTextField.frame.origin.y + OFFSET, _passwordTextField.frame.size.width, _passwordTextField.frame.size.height);
        _loginButton.frame = CGRectMake(_loginButton.frame.origin.x, _loginButton.frame.origin.y + OFFSET, _loginButton.frame.size.width, _loginButton.frame.size.height);
    }
}


#pragma mark - Web Service Response

- (void)getLoginResults:(NSDictionary *)results error:(NSError *)error {
    if (error == NULL) { // Success
        // Validates the user and password
        if ([[results objectForKey:@"success"] boolValue]) {
            // Saves the user data
            [FeedUserDefaults setToken:[results valueForKey:@"token"]];
            [FeedUserDefaults setPassword:_passwordTextField.text];
            [FeedUserDefaults setUser:_userTextField.text];
            [FeedUserDefaults setName:[(User *)[results valueForKey:@"user"] name]];

            // Redirects to enter a new PIN
            PPPinPadViewController * pinViewController = [[PPPinPadViewController alloc] initWithMode:kNeverSet];
            [pinViewController setBackgroundImage:[Utility getScreenshot:self.view]];
            pinViewController.delegate = self;
            [self presentViewController:pinViewController animated:YES completion:NULL];

            NSLog(@"EVENT: %@", NSLocalizedString(@"Login_Success", nil));
        } else {
            // Shows the error message
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login_Title", nil)
                                                            message:NSLocalizedString(@"Login_InvalidCredentials", nil)
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OkButton", nil)
                                                  otherButtonTitles:nil];
            [alert show];

            // Clean password field and set the focus in the user field
            _passwordTextField.text = @"";
            [_passwordTextField becomeFirstResponder];

            NSLog(@"EVENT: %@", NSLocalizedString(@"Login_InvalidCredentials", nil));
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login_Title", nil)
                                                        message:NSLocalizedString(@"Connection_Error", nil)
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OkButton", nil)
                                              otherButtonTitles: nil];
        [alert show];

        [_loginButton setEnabled:YES];
        NSLog(@"EVENT: %@", NSLocalizedString(@"Connection_Error", nil));
    }
}


@end