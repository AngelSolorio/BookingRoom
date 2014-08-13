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
        customColor = [UIColor colorWithRed:205./255. green:231./255. blue:188./255. alpha:0.8];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];

    customColor = [UIColor colorWithRed:205./255. green:231./255. blue:188./255. alpha:0.8];

    [self.layer setCornerRadius:CGRectGetHeight(rect)/2.0];
    self.layer.borderColor = customColor.CGColor;
    self.layer.borderWidth = 1.5f;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    if(highlighted) {
        self.layer.backgroundColor = customColor.CGColor;
    } else {
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
    }
}

@end