//
//  MyBookingsTableViewCell.h
//  Booking Room
//
//  Created by Sandra Guzman on 06/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Booking.h"

@protocol MyBookingsCellDelegate;

@interface MyBookingsTableViewCell : UITableViewCell

@property (nonatomic, strong) Booking *booking;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, weak) id<MyBookingsCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

// view buttons
@property (weak, nonatomic) IBOutlet UIView *buttonsContainerView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *deleteLabel;

// view details bookings
@property (weak, nonatomic) IBOutlet UIView *innerContentView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *bookingIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (IBAction)buttonDeleteTouched:(id)sender;
    
@end

@protocol MyBookingsCellDelegate <NSObject>

@end

