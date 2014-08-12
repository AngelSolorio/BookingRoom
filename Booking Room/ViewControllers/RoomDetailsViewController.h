//
//  RoomDetailsViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomDetailsCollectionViewCell.h"
#import "MenuItem.h"
#import "MeetingRoom.h"

@interface RoomDetailsViewController : UIViewController <UIScrollViewDelegate, UICollectionViewDelegate> {
    NSArray *roomDetailsItems;
}

@property (nonatomic, retain) MeetingRoom *meetingRoom;
@property (weak, nonatomic) IBOutlet UIScrollView *roomImageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *imagePageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *roomDetailsCollectionView;

- (id)initWithMeetingRoom:(MeetingRoom *)aMeetingRoom;

@end
