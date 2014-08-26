//
//  AssistantTableViewCell.m
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "AssistantTableViewCell.h"

@implementation AssistantTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
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

- (void)setPersonItem:(Person *)personItem {
    if (_personItem != personItem) {
        _personItem = personItem;
        _namePerson.text = _personItem.name;
        _companyPerson.text = _personItem.company;
        _positionPerson.text = _personItem.position;
    }
}

@end
