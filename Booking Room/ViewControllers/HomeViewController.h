//
//  HomeViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingRoom.h"
#import "MeetingRoomCollectionViewCell.h"


@interface HomeViewController : UIViewController <UICollectionViewDataSource> {
    NSMutableArray *meetingRoomsArray;
    NSInteger selectedMeetingRoom;
    UIColor *customGreenColor;
}

@property (weak, nonatomic) IBOutlet UICollectionView *meetingRoomsCollection;

@end
