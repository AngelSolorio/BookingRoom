//
//  RootViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 22/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)awakeFromNib {
    // Configures the menu
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.menuPrefersStatusBarHidden = NO;
    self.contentViewShadowColor = [UIColor blackColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    self.contentViewShadowEnabled = YES;
    self.contentViewController = [[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"homeController"]];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftMenuViewController"];
    self.backgroundImage = [UIImage imageNamed:@"BackgroundMenu"];
    self.delegate = self;
}


#pragma mark - RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController {
    //NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}


- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController {
    //NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}


#pragma mark - UIInterfaceOrientation Methods

- (BOOL)shouldAutorotate {
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
