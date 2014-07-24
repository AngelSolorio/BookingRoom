//
//  LoginViewController.h
//  Booking Room
//
//  Created by Angel Solorio on 7/22/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginUser:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
