//
//  LeftMenuViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 22/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "RNGridMenu.h"
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface LeftMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RESideMenuDelegate, RNGridMenuDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
     NSArray *menuItems;
     ACAccountStore *accountStore;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *userPicture;

@end
