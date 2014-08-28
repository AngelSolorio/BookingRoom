//
//  ActionSheetCalendarViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 27/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ImageEffects.h"

@protocol ActionSheetCalendarDelegate <NSObject>
@required
-(void)setSelectedDatePicker:(NSDate *)date;
@end

@interface ActionSheetCalendarViewController : UIViewController

@property (weak, nonatomic) id <ActionSheetCalendarDelegate> delegate;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *titleCalendar;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;

- (IBAction)closePicker:(id)sender;
- (IBAction)selectedDatePicker:(id)sender;
@end
