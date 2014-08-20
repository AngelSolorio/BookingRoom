//
//  RoomDetailsCollectionViewCell.h
//  Booking Room
//
//  Created by Sandra Guzman on 07/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "UIImageView+AFNetworking.h"
#import "RMDownloadIndicator.h"
#import "Utility.h"

@interface RoomDetailsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) Service *serviceItem;
@property (weak, nonatomic) IBOutlet UIImageView *iconRoomDetail;
@property (weak, nonatomic) IBOutlet UILabel *titleRoomDetail;
@property (weak, nonatomic) IBOutlet RMDownloadIndicator *downloadIndicator;

- (void)setRoomDetailItem:(Service *)serviceItem;

@end
