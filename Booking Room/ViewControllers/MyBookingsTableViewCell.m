//
//  MyBookingsTableViewCell.m
//  Booking Room
//
//  Created by Sandra Guzman on 06/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "MyBookingsTableViewCell.h"

@implementation MyBookingsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setBooking:(Booking *)booking {
    if (_booking != booking) {
        _booking = booking;
        _titleLabel.text = booking.title;
        NSDateFormatter *dataFormat = [NSDateFormatter new];
        [dataFormat setDateFormat:@"dd/MM/yyyy  h:mm a"];
        NSString *startDateString = [dataFormat stringFromDate:booking.startDate];
        NSString *endDateString = [dataFormat stringFromDate:booking.endDate];
        _startDateLabel.text = startDateString;
        _endDateLabel.text = endDateString;
        _ownerLabel.text = booking.owner.name;
        int priority = [booking.priority intValue];
        
        float radius = 8.0f;
        UIColor *color;
        
        switch (priority) {
            case 0:
                color = [UIColor greenColor];
                break;
            case 1:
                color = [UIColor yellowColor];
                break;
            case 2:
                color = [UIColor orangeColor];
                break;
            case 3:
                color = [UIColor redColor];
                break;
            default:
                break;
        }
        
        UIView *circleStatus = [self getCircleViewAtPoint:CGPointMake(_titleLabel.frame.size.width - 20, 0) withRadious:radius andColor:color];
        [_titleLabel addSubview:circleStatus];
    }
}

- (UIView *)getCircleViewAtPoint:(CGPoint)point withRadious:(float)radius andColor:(UIColor *)color {
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, radius * 2.0f, radius * 2.0f)];
    circleView.layer.cornerRadius = radius;
    circleView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75].CGColor;
    circleView.layer.borderWidth = 2.0f;
    circleView.layer.backgroundColor = color.CGColor;
    circleView.tag = 77;
    return circleView;
}

@end
