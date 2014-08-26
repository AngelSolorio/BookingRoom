//
//  AddAssistentViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import "Utility.h"
#import "UIImage+ImageEffects.h"
#import "AssistantTableViewCell.h"

@interface AddAssistentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate> {
    NSMutableArray *assistantItems;
    BOOL searching;
    NSMutableArray *copyListOfItems;
    __weak IBOutlet UILabel *emptyLabel;
    CGFloat animatedDistance;
}

// View Create Assistant
@property (weak, nonatomic) IBOutlet RoundImageView *photo;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

// View Sellcom
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *sellcomTable;

// View PopOver
@property (nonatomic, strong) UIImage *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentAssistants;
@property (weak, nonatomic) IBOutlet UIScrollView *viewSellcom;
@property (weak, nonatomic) IBOutlet UIScrollView *viewCreateAssistant;

- (IBAction)closePopOver:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

@end
