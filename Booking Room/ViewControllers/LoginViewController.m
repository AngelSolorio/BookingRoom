//
//  LoginViewController.m
//  Booking Room
//
//  Created by Angel Solorio on 7/22/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

}


@end