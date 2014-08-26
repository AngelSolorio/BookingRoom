//
//  BookingAssistantsViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMStepsController.h"
#import "AssistantTableViewCell.h"
#import "Person.h"
#import "AddAssistentViewController.h"

@interface BookingAssistantsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    NSMutableArray *assistantItems;
    BOOL searching;
    NSMutableArray *copyListOfItems;
    __weak IBOutlet UILabel *emptyLabel;
}

@property (weak, nonatomic) IBOutlet UIButton *addPerson;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *assistantsTable;

- (IBAction)nextStep:(id)sender;
- (IBAction)addAssistant:(id)sender;

@end
