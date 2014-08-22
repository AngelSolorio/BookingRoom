//
//  MeetingRoomCollectionViewCell.m
//  Booking Room
//
//  Created by Angel Solorio on 8/21/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "MeetingRoomCollectionViewCell.h"

@implementation MeetingRoomCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setMeetingRoom:(MeetingRoom *)meetingRoom {
    if (_meetingRoom != meetingRoom) {
        _meetingRoom = meetingRoom;
        _iconView.image = meetingRoom.icon;

        // Sets the normal background
        RoundImageView *roundImage = [[RoundImageView alloc] initWithImage:_iconView.image];
        roundImage.layer.borderColor = [UIColor clearColor].CGColor;
        [roundImage setBackgroundColor:[UIColor clearColor]];
        [self setBackgroundView:roundImage];

        // Sets the selected background
        roundImage = [[RoundImageView alloc] initWithImage:_iconView.image];
        roundImage.layer.borderColor = [UIColor clearColor].CGColor;
        [roundImage setBackgroundColor:[UIColor colorWithRed:150/255. green:209/255. blue:124/255. alpha:0.5]];
        [self setSelectedBackgroundView:roundImage];
    }
}


@end
