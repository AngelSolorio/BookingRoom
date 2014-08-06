//
//  MyBookingsTableViewCell.m
//  Booking Room
//
//  Created by Sandra Guzman on 06/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "MyBookingsTableViewCell.h"

const CGFloat kRevealWithWidth = 100.f;
static NSString *RevealContactCellDidOpenNotification = @"RevealContactCellDidOpenNotification";

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
        NSString *dateString = [dataFormat stringFromDate:booking.date];
        _dateLabel.text = dateString;
        _bookingIcon.image = booking.photo;
        
        float radius = 8.0f;
        UIColor *color;
        
        switch (booking.priority) {
            case 1:
                color = [UIColor redColor];
                break;
            case 2:
                color = [UIColor orangeColor];
                break;
            case 3:
                color = [UIColor greenColor];
                break;
            default:
                break;
        }
        
        UIView *circleStatus = [self getCircleViewAtPoint:CGPointMake(_dateLabel.frame.size.width + _dateLabel.frame.origin.x + 5, _dateLabel.frame.origin.y) withRadious:radius andColor:color];
        [_innerContentView addSubview:circleStatus];
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

- (void)awakeFromNib {
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOpen:) name:RevealContactCellDidOpenNotification object:nil];
    
    // Set the buttons titles
    //[_buttonCall setTitle:[Utility localize:@"CallButton"] forState:UIControlStateNormal];
    //[_buttonEmail setTitle:[Utility localize:@"MailButton"] forState:UIControlStateNormal];
}

- (void)onOpen:(NSNotification *)notification {
    if (notification.object != self) {
        if (_isOpen) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.25 animations:^{
                    _scrollView.contentOffset = CGPointZero;
                }];
            });
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width + kRevealWithWidth, self.scrollView.frame.size.height);
    
    [self repositionButtons];
}

- (void)repositionButtons {
    CGRect frame = _buttonsContainerView.frame;
    frame.origin.x = _scrollView.contentOffset.x;
    _buttonsContainerView.frame = frame;
}

- (void)closeCell {
    _scrollView.contentOffset = CGPointZero;
}


#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self repositionButtons];
    
    if (_scrollView.contentOffset.x < 0) {
        _scrollView.contentOffset = CGPointZero;
    }
    
    if (_scrollView.contentOffset.x >= kRevealWithWidth) {
        _isOpen = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:RevealContactCellDidOpenNotification object:self];
    } else {
        _isOpen = NO;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (velocity.x > 0) {
        (*targetContentOffset).x = kRevealWithWidth;
    } else {
        (*targetContentOffset).x = 0;
    }
}


#pragma mark - IBActions Methods

- (IBAction)buttonDeleteTouched:(id)sender {
    NSLog(@"Delete");
}

@end
