//
//  RoomDetailsCollectionViewCell.m
//  Booking Room
//
//  Created by Sandra Guzman on 07/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "RoomDetailsCollectionViewCell.h"

@implementation RoomDetailsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setRoomDetailItem:(MenuItem *)menuItem {
    if (_menuItem != menuItem) {
        _menuItem = menuItem;
        
        _titleRoomDetail.text = _menuItem.title;
        _iconRoomDetail.image = _menuItem.icon;
    }
}

@end
