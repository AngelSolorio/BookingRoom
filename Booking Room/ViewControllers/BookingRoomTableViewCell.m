//
//  BookingRoomTableViewCell.m
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "BookingRoomTableViewCell.h"

@implementation BookingRoomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    // Sets the download indicator
    RMDownloadIndicator *closedIndicator = [[RMDownloadIndicator alloc] initWithFrame:CGRectMake(18, 3, 84, 84)
                                                                                 type:kRMClosedIndicator];
    [closedIndicator setBackgroundColor:[UIColor clearColor]];
    [closedIndicator setFillColor:[UIColor grayColor]];
    [closedIndicator setStrokeColor:[UIColor whiteColor]];
    closedIndicator.radiusPercent = 0.45;
    [closedIndicator loadIndicator];
    _downloadIndicator = closedIndicator;
    [self.viewForBaselineLayout addSubview:_downloadIndicator];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMeetingRoomItem:(MeetingRoom *)meetingRoomItem {
    if (_meetingRoomItem != meetingRoomItem) {
        _meetingRoomItem = meetingRoomItem;
        _nameBooking.text = _meetingRoomItem.name;
        _detailsBooking.text = _meetingRoomItem.location;
        _capacity.text = [NSString stringWithFormat:@"%@", _meetingRoomItem.capacity];
        
        if (meetingRoomItem.photo.count > 0) {
            [_downloadIndicator setHidden:NO];
            // Request the image to the Web Services
            Photo *photo = [meetingRoomItem.photo objectAtIndex:0];
            
            UIImage *imageSave = [Utility getImageFromFileSystem:[NSString stringWithFormat:@"%@_%@.png",_meetingRoomItem.name, photo.identifier]
                                                        inFolder:@"MeetingRoom"];
            if (imageSave) {
                _iconBooking.image = imageSave;
                [_downloadIndicator setHidden:YES];
            } else {
                [_iconBooking setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:photo.url]]
                                    placeholderImage:[UIImage imageNamed:@"MeetingRooms"]
                                             success:^(NSURLRequest *request , NSHTTPURLResponse *response , UIImage *image ){
                                                 [_downloadIndicator setIndicatorAnimationDuration:1.0];
                                                 [_downloadIndicator updateWithTotalBytes:100 downloadedBytes:100];
                                                 photo.image = image ? image : [UIImage imageNamed:@"MeetingRooms"];
                                                 _iconBooking.image = image ? image : [UIImage imageNamed:@"MeetingRooms"];
                                                 [Utility saveImageToFileSystem:image withFileName:[NSString stringWithFormat:@"%@_%@.png",_meetingRoomItem.name, photo.identifier]
                                                                       inFolder:@"MeetingRoom"];
                                                 NSLog(@"Loaded successfully: %ld", (long)[response statusCode]);
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                 NSLog(@"failed loading: %@", error);
                                                 [_downloadIndicator setHidden:YES];
                                                 NSLog(@"Error loading dish picture: %@", error.description);
                                             }
                 ];
            }
        }
    }
}

@end
