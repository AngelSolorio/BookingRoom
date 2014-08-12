//
//  WelcomeViewController.m
//  Booking Room
//
//  Created by Angel Solorio on 8/5/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "WelcomeViewController.h"
#import "TypeDefs.h"

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the title's controls
    [_enterButton setTitle:NSLocalizedString(@"Login_EnterButton", nil) forState:UIControlStateNormal];
    [_switchUserButton setTitle:NSLocalizedString(@"Login_SwithUserButton", nil) forState:UIControlStateNormal];
    [_resetPinButton setTitle:NSLocalizedString(@"Login_ResetPin", nil) forState:UIControlStateNormal];
    
    // Loads the logged user's info
    _userLabel.text = [[FeedUserDefaults name] length] != 0 ? [FeedUserDefaults name] : [FeedUserDefaults user];
    UIImage *picture = [Utility getImageFromFileSystem:[NSString stringWithFormat:@"user_%@.png", [FeedUserDefaults user]]
                                              inFolder:@"People"];
    _userPictureView.image = picture ? picture : [UIImage imageNamed:@"ImageContact"];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // Hides the Navigation Bar
    [self.navigationController setNavigationBarHidden:YES];
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


#pragma mark - IBActions

- (IBAction)authenticatePin:(id)sender {
    // Redirects to enter a new PIN
    PPPinPadViewController *pinViewController = [[PPPinPadViewController alloc] initWithMode:kAlreadySet];
    [pinViewController setBackgroundImage:[Utility getScreenshot:self.view]];
    pinViewController.delegate = self;
    [self presentViewController:pinViewController animated:YES completion:NULL];
}


- (IBAction)switchUser:(id)sender {
    // Cleans credentials
    [FeedUserDefaults setPin:@""];
    [FeedUserDefaults setUser:@""];
    [FeedUserDefaults setPassword:@""];
    [FeedUserDefaults setToken:@""];

    NSLog(@"EVENT: %@", NSLocalizedString(@"Bye_SuccessfulMessage", nil));

    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)resetPin:(id)sender {
    [self showAlertWithTitle:NSLocalizedString(@"Login_Password", nil)
                     message:NSLocalizedString(@"Login_Message", nil)];
}


#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    }

    UITextField *textfield = [alertView textFieldAtIndex:0];
    if ([[FeedUserDefaults password] isEqualToString:textfield.text]) { // Correct password
        // Redirects to enter a new PIN
        PPPinPadViewController *pinViewController = [[PPPinPadViewController alloc] initWithMode:kNeverSet];
        [self presentViewController:pinViewController animated:YES completion:NULL];
        pinViewController.delegate = self;
    } else {
        [self showAlertWithTitle:NSLocalizedString(@"Login_IncorrectPassword", nil)
                         message:NSLocalizedString(@"Login_MessageAgain", nil)];
    }
}


- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    // shows an alert to enter the password
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"CancelButton", nil)
                                              otherButtonTitles:NSLocalizedString(@"ContinueButton", nil), nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

    UITextField* textfield = [alertView textFieldAtIndex:0];
    textfield.placeholder = NSLocalizedString(@"Login_Password", nil);
    textfield.secureTextEntry = YES;

    [alertView show];
}


#pragma mark - PinPadPasswordProtocol Methods

- (BOOL)checkPin:(NSString *)pin {
    BOOL result = NO;
    if ([pin isEqualToString:[FeedUserDefaults pin]]) {
        result = YES;
    }

    return result;
}


- (NSInteger)pinLenght {
    return 4;
}


- (void)pinAuthenticatedInViewController:(UIViewController *)pvc {
    // Dismiss the PIN View Controller
    [pvc dismissViewControllerAnimated:NO completion:^{
//        if ([(MainNavigationController *)self.navigationController newsToNotify]) {
//            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            HomeViewController *homeViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"homeViewController"];
//            NewsViewController *newsViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"newsViewController"];
//            DetailNewsViewController *detailNewsViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"detailNewsViewController"];
//            News *news = [(MainNavigationController *)self.navigationController newsToNotify];
//            [detailNewsViewController setNews:news];
//            NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithArray:[self.navigationController viewControllers]];
//            [viewControllers addObject:homeViewController];
//            [viewControllers addObject:newsViewController];
//            [viewControllers addObject:detailNewsViewController];
//            [self.navigationController setViewControllers:viewControllers];
//        } else {
            // Shows the home view
            [self performSegueWithIdentifier:@"welcomeToRoot" sender:self];
//        }
    }];
}


- (void)newPinSet:(NSString *)newPin inViewController:(UIViewController *)pvc {
    // Dismiss the PIN View Controller
    [pvc dismissViewControllerAnimated:NO completion:^{
        // Shows the home view
        [self performSegueWithIdentifier:@"welcomeToRoot" sender:self];
    }];

    // Stores the new PIN set
    [FeedUserDefaults setPin:newPin];
}


@end
