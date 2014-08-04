//
//  MainNavigationController.m
//  Booking Room
//
//  Created by Angel Solorio on 8/4/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "MainNavigationController.h"

@implementation MainNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    _byeViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"byeViewController"];
}

#pragma mark - Navigation

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    UIInterfaceOrientation orientation = [self.topViewController preferredInterfaceOrientationForPresentation];
    if (orientation > 0) {
        return orientation;
    } else {
        return UIInterfaceOrientationPortrait;
    }
}


#pragma mark - Custom Methods

- (void)sendToLogoutView {
    if ([FeedUserDefaults reloginAvailable]) {
        [FeedUserDefaults setReloginAvailable:NO];

//        [_byeViewController setTextToDisplay:[Utility localize:@"Bye_ExpiredSession"]];
        [self presentViewController:nil //_byeViewController
                           animated:YES
                         completion:^{
                             [self popToRootViewControllerAnimated:YES];
                             [self performSelector:@selector(loadLogupViewController) withObject:nil afterDelay:2.0];
                         }];
    }
}


- (void)loadLogupViewController {
    // Cleans credentials
    [FeedUserDefaults setPin:@""];
    [FeedUserDefaults setPassword:@""];
    [FeedUserDefaults setToken:@""];

    // Dissmiss the view controllers and shows the logupview
//    [_byeViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
