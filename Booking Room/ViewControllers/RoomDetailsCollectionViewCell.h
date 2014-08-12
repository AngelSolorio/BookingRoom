//
//  RoomDetailsCollectionViewCell.h
//  Booking Room
//
//  Created by Sandra Guzman on 07/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

@interface RoomDetailsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) MenuItem *menuItem;
@property (weak, nonatomic) IBOutlet UIImageView *iconRoomDetail;
@property (weak, nonatomic) IBOutlet UILabel *titleRoomDetail;

- (void)setRoomDetailItem:(MenuItem *)menuItem;

@end
