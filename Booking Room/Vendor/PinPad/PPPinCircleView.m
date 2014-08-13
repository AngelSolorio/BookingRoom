//
//  VTPinCircleImageView.m
//  Booking Room
//
//  Created by Angel Solorio on 2/27/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.


#import "PPPinCircleView.h"

@implementation PPPinCircleView

+ (instancetype)circleView:(CGFloat)radius {
    PPPinCircleView * circleView = [[PPPinCircleView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, radius*2.0f, radius*2.0f)];
    circleView.layer.cornerRadius = radius;
    circleView.layer.borderColor = [UIColor colorWithRed:205./255. green:231./255. blue:188./255. alpha:0.8].CGColor;
    circleView.layer.borderWidth = 2.0f;
    return circleView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        customColor = customColor = [UIColor colorWithRed:205./255. green:231./255. blue:188./255. alpha:0.8];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
