//
//  RoomDetailsTableViewCell.m
//  Booking Room
//
//  Created by Sandra Guzman on 24/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "RoomDetailsTableViewCell.h"

@implementation RoomDetailsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRoomDetailItem:(MenuItem *)menuItem {
    if (_menuItem != menuItem) {
        _menuItem = menuItem;
        
        _titleRoomDetail.text = _menuItem.title;
        _iconRoomDetail.image = _menuItem.icon;
    }
}

@end
