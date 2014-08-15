//
//  BookingRoomTableViewCell.h
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingRoom.h"
#import "RoundImageView.h"

@interface BookingRoomTableViewCell : UITableViewCell

@property (nonatomic, strong) MeetingRoom *meetingRoomItem;
@property (weak, nonatomic) IBOutlet RoundImageView *iconBooking;
@property (weak, nonatomic) IBOutlet UILabel *nameBooking;
@property (weak, nonatomic) IBOutlet UILabel *detailsBooking;

@end
