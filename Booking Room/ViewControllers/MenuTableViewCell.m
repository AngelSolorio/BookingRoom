//
//  MenuTableViewCell.m
//  Palacio De Hierro
//
//  Created by Angel Solorio on 5/29/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

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


- (void)setMenuItem:(MenuItem *)menuItem {
    if (_menuItem != menuItem) {
        _menuItem = menuItem;

        _titleMenu.text = _menuItem.title;
        _iconMenu.image = _menuItem.icon;
    }
}

@end
