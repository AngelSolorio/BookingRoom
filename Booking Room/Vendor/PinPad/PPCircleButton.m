//
//  VTCircleButton.m
//  Booking Room
//
//  Created by Angel Solorio on 2/27/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.


#import "PPCircleButton.h"

@implementation PPCircleButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];

    [self.layer setCornerRadius:CGRectGetHeight(rect)/2.0];
    self.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
    self.layer.borderWidth = 2.0f;
}

- (void)setHighlighted:(BOOL)highlighted {
    if(highlighted) {
        self.layer.borderColor = [UIColor colorWithRed:255./255. green:105./255. blue:110./255. alpha:0.5].CGColor;
        self.layer.backgroundColor = [UIColor colorWithRed:255./255. green:105./255. blue:110./255. alpha:.75].CGColor;
    } else {
        self.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
    }
}

@end