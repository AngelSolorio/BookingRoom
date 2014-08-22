//
//  RootViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 22/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "LeftMenuViewController.h"
#import "HomeViewController.h"

@interface RootViewController : RESideMenu <RESideMenuDelegate> { 
    BOOL leftMenuVisible;
    UIViewController *topViewController;
}


@end
