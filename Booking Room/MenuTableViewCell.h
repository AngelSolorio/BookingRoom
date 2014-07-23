//
//  MenuTableViewCell.h
//  Palacio De Hierro
//
//  Created by Angel Solorio on 5/29/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

@interface MenuTableViewCell : UITableViewCell

@property (nonatomic, strong) MenuItem *menuItem;
@property (weak, nonatomic) IBOutlet UIImageView *iconMenu;
@property (weak, nonatomic) IBOutlet UILabel *titleMenu;

@end
