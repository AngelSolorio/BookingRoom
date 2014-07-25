//
//  LoginViewController.h
//  Booking Room
//
//  Created by Angel Solorio on 7/22/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedUserDefaults.h"
#import "PPPinPadViewController.h"
#import <MRProgress/MRProgress.h>
#import "WebService.h"

@interface LoginViewController : UIViewController <PinPadPasswordProtocol, UITextFieldDelegate> {
    MRProgressOverlayView *progressView;
}

@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginUser:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
