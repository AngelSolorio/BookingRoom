//
//  DayCollectionViewCell.m
//  Booking Room
//
//  Created by Angel Solorio on 8/25/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "DayCollectionViewCell.h"

@implementation DayCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;

        // Creates the attributed string
        NSMutableAttributedString *attributtedString = [[NSMutableAttributedString alloc] initWithString:[self getFormattedString:_title]];
        [attributtedString addAttribute:NSFontAttributeName
                                  value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0]
                                  range:NSMakeRange(0,1)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init] ;
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        [attributtedString addAttribute:NSParagraphStyleAttributeName
                                  value:paragraphStyle
                                  range:NSMakeRange(0,1)];
        [_titleLabel setAttributedText:attributtedString];

        // Sets the normal background
        RoundImageView *roundImage = [[RoundImageView alloc] initWithImage:_iconView.image];
        roundImage.layer.borderColor = [UIColor clearColor].CGColor;
        [roundImage setBackgroundColor:[UIColor clearColor]];
        [self setBackgroundView:roundImage];

        // Sets the selected background
        roundImage = [[RoundImageView alloc] initWithImage:_iconView.image];
        roundImage.layer.borderColor = [UIColor clearColor].CGColor;
        [roundImage setBackgroundColor:[UIColor colorWithRed:150/255. green:209/255. blue:124/255. alpha:1.0]];
        [self setSelectedBackgroundView:roundImage];
    }
}

- (NSString *)getFormattedString:(NSString *)string {
    NSMutableString *displayString = [NSMutableString stringWithString:@""];

    NSArray *words = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if ([words count]) {
        NSString *firstWord = words[0];
        if ([firstWord length]) {
            [displayString appendString:[firstWord substringWithRange:NSMakeRange(0, 1)]];
        }

        if ([words count] >= 2) {
            //[displayString appendString:@" "];
            NSString *lastWord = words[[words count] - 1];
            if ([lastWord length] == 1) {
                [displayString appendString:[lastWord substringWithRange:NSMakeRange(0, 1)]];
            } else if ([lastWord length] >= 2) {
                [displayString appendString:[lastWord substringWithRange:NSMakeRange(0, 2)]];
            }
        }
    }

    return [displayString uppercaseString];
}


@end
