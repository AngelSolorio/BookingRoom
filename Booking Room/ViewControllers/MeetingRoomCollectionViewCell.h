//
//  MeetingRoomCollectionViewCell.h
//  Booking Room
//
//  Created by Angel Solorio on 8/21/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundImageView.h"
#import "MeetingRoom.h"

@interface MeetingRoomCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) MeetingRoom *meetingRoom;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
