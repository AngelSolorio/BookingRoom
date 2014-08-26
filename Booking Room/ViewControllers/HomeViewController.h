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
#import "DayCollectionViewCell.h"
#import "Utility.h"


@interface HomeViewController : UIViewController <UICollectionViewDataSource> {
    NSMutableArray *meetingRoomsArray;
    NSMutableArray *daysOfMonthArray;
    NSInteger selectedMeetingRoom;
    NSDate *selectedDate;
    UIColor *customGreenColor;
}

@property (weak, nonatomic) IBOutlet UICollectionView *meetingRoomsCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *daysOfMonthCollection;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (IBAction)previousMonth:(id)sender;
- (IBAction)nextMonth:(id)sender;

@end
