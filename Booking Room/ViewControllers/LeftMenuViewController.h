//
//  LeftMenuViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 22/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import <FacebookSDK/FacebookSDK.h>
#import "RESideMenu.h"
#import "RNGridMenu.h"
#import "RoundImageView.h"
#import "FHSTwitterEngine.h"
#import "MenuTableViewCell.h"
#import "Utility.h"
#import "FeedUserDefaults.h"
#import "UIImageView+Letters.h"
#import "ImageEditorViewController.h"
#import "PPPinPadViewController.h"
#import "MRProgress.h"

@interface LeftMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, RESideMenuDelegate, RNGridMenuDelegate, PinPadPasswordProtocol, HFImageEditorFrame> {
    NSArray *menuItems;
    ACAccountStore *accountStore;
    MRProgressOverlayView *progressView;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet RoundImageView *userPicture;
@property (nonatomic, retain) UIImagePickerController *imagePickController;
@property (nonatomic,strong) ImageEditorViewController *imageEditor;

@end
