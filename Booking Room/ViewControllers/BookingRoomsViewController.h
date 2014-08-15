//
//  SalasViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookingRoomTableViewCell.h"
#import "MeetingRoom.h"
#import "WebService.h"

@interface BookingRoomsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    NSArray *meetingRoomItems;
    BOOL searching;
    NSMutableArray *copyListOfItems;
    __weak IBOutlet UILabel *emptyLabel;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *bookingRoomTable;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end
