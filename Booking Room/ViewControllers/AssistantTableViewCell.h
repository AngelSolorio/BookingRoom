//
//  AssistantTableViewCell.h
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "RoundImageView.h"
#import "UIImageView+AFNetworking.h"
#import "RMDownloadIndicator.h"
#import "Utility.h"

@interface AssistantTableViewCell : UITableViewCell

@property (nonatomic, strong) Person *personItem;
@property (weak, nonatomic) IBOutlet RoundImageView *photoPerson;
@property (weak, nonatomic) IBOutlet UILabel *namePerson;
@property (weak, nonatomic) IBOutlet UILabel *companyPerson;
@property (weak, nonatomic) IBOutlet UILabel *positionPerson;
@property (weak, nonatomic) IBOutlet RMDownloadIndicator *downloadIndicator;

@end
