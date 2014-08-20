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

- (void)awakeFromNib {
    // Initialization code
    // Sets the download indicator
    RMDownloadIndicator *closedIndicator = [[RMDownloadIndicator alloc] initWithFrame:CGRectMake(15, 0, 70, 70)
                                                                                 type:kRMClosedIndicator];
    [closedIndicator setBackgroundColor:[UIColor clearColor]];
    [closedIndicator setFillColor:[UIColor grayColor]];
    [closedIndicator setStrokeColor:[UIColor whiteColor]];
    closedIndicator.radiusPercent = 0.45;
    [closedIndicator loadIndicator];
    _downloadIndicator = closedIndicator;
}

- (void)setRoomDetailItem:(Service *)serviceItem {
    if (_serviceItem != serviceItem) {
        _serviceItem = serviceItem;
        _titleRoomDetail.text = _serviceItem.name;
        _iconRoomDetail.image = _serviceItem.photo.image;
        
        switch ([_serviceItem.photo.identifier intValue]) {
            case 1:
                _iconRoomDetail.image = [UIImage imageNamed:@"Wifi"];
                break;
            case 2:
                _iconRoomDetail.image = [UIImage imageNamed:@"Projector"];
                break;
            case 3:
                _iconRoomDetail.image = [UIImage imageNamed:@"Screen"];
                break;
            case 4:
                _iconRoomDetail.image = [UIImage imageNamed:@"AirConditioning"];
                break;
            default:
                if (_serviceItem.photo.url != nil) {
                    [self.viewForBaselineLayout addSubview:_downloadIndicator];
                    [_downloadIndicator setHidden:NO];
                    
                    UIImage *imageSave = [Utility getImageFromFileSystem:[NSString stringWithFormat:@"%@_%@.png",_serviceItem.name, _serviceItem.identifier]
                                                                inFolder:@"Services"];
                    if (imageSave) {
                        _iconRoomDetail.image = imageSave;
                        [_downloadIndicator setHidden:YES];
                    } else {
                        // Request the image to the Web Service
                        [_iconRoomDetail setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_serviceItem.photo.url]]
                                               placeholderImage:[UIImage imageNamed:@"MeetingRooms"]
                                                        success:^(NSURLRequest *request , NSHTTPURLResponse *response , UIImage *image ){
                                                            [_downloadIndicator setIndicatorAnimationDuration:1.0];
                                                            [_downloadIndicator updateWithTotalBytes:100 downloadedBytes:100];
                                                            _iconRoomDetail.image = image ? image : [UIImage imageNamed:@"MeetingRooms"];
                                                            [Utility saveImageToFileSystem:image withFileName:[NSString stringWithFormat:@"%@_%@.png",_serviceItem.name, _serviceItem.identifier] inFolder:@"Services"];
                                                            NSLog(@"Loaded successfully: %d", [response statusCode]);
                                                        }
                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                            NSLog(@"failed loading: %@", error);
                                                            [_downloadIndicator setHidden:YES];
                                                            NSLog(@"Error loading dish picture: %@", error.description);
                                                        }
                         ];
                    }
                }
                break;
        }
    }
}

@end
