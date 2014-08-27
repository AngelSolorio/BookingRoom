//
//  BookingRoomViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMStepsController.h"
#import "BookingRoomTableViewCell.h"
#import "MeetingRoom.h"
#import "WebService.h"
#import "DTCustomColoredAccessory.h"

@interface MeetingRoomsAvailableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    NSArray *meetingRoomAvailableItems;
    BOOL searching;
    NSMutableArray *copyListOfItems;
    __weak IBOutlet UILabel *emptyLabel;
}

@property (weak, nonatomic) IBOutlet UITableView *meetingRoomsAvailableTable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

- (IBAction)saveBooking:(id)sender;

@end
