//
//  ReservacionesViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBookingsTableViewCell.h"
#import "Booking.h"

@interface MyBookingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    NSMutableArray *myBookingsItems;
    BOOL searching;
    NSMutableArray *copyListOfItems;
    __weak IBOutlet UILabel *emptyLabel;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *myBookingsTable;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

- (IBAction)editMyBookings:(id)sender;

@end
