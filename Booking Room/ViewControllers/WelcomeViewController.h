//
//  WelcomeViewController.h
//  Booking Room
//
//  Created by Angel Solorio on 8/5/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPPinPadViewController.h"
#import "RootViewController.h"
#import "LoginViewController.h"
#import "MainNavigationController.h"
#import "FeedUserDefaults.h"
#import "RoundImageView.h"
#import "Utility.h"

@interface WelcomeViewController : UIViewController <PinPadPasswordProtocol, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *enterButton;
@property (weak, nonatomic) IBOutlet UIButton *switchUserButton;
@property (weak, nonatomic) IBOutlet UIButton *resetPinButton;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet RoundImageView *userPictureView;

- (IBAction)authenticatePin:(id)sender;
- (IBAction)switchUser:(id)sender;
- (IBAction)resetPin:(id)sender;

@end
