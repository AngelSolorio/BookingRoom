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

@interface BookingRoomsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *meetingRoomItems;
}

@property (weak, nonatomic) IBOutlet UITableView *bookingRoomTable;

@end
