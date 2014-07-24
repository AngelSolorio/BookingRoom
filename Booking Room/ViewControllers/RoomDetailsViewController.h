//
//  RoomDetailsViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomDetailsTableViewCell.h"
#import "MenuItem.h"


@interface RoomDetailsViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate> {
    NSArray *roomDetailsItems;
}

@property (nonatomic, retain) NSString *titleView;
@property (weak, nonatomic) IBOutlet UIScrollView *roomImageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *imagePageControl;
@property (weak, nonatomic) IBOutlet UITableView *roomDetailsTable;

- (id)initWithTitleName:(NSString *)title;

@end
