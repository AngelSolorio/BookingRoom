//
//  BookingRoomTableViewCell.m
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "BookingRoomTableViewCell.h"

@implementation BookingRoomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMeetingRoomItem:(MeetingRoom *)meetingRoomItem {
    if (_meetingRoomItem != meetingRoomItem) {
        _meetingRoomItem = meetingRoomItem;
        
        _nameBooking.text = _meetingRoomItem.name;
        _detailsBooking.text = _meetingRoomItem.location;
    }
}

@end
