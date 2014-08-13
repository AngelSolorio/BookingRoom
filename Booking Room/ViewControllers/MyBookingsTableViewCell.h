//
//  MyBookingsTableViewCell.h
//  Booking Room
//
//  Created by Sandra Guzman on 06/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Booking.h"

@interface MyBookingsTableViewCell : UITableViewCell

@property (nonatomic, strong) Booking *booking;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;

@end

