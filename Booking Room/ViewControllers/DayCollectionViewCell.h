//
//  DayCollectionViewCell.h
//  Booking Room
//
//  Created by Angel Solorio on 8/25/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+Letters.h"
#import "RoundImageView.h"

@interface DayCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
