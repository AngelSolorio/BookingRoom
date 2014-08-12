//
//  RoomDetailsViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "RoomDetailsViewController.h"

@interface RoomDetailsViewController ()

@end

@implementation RoomDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithMeetingRoom:(MeetingRoom *)aMeetingRoom {
    self = [super init];
    if (self) {
        self.meetingRoom = aMeetingRoom;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < _meetingRoom.photo.count; i++) {
        CGFloat xOrigin = i * _roomImageScrollView.frame.size.width;
        UIImageView *image = [[UIImageView alloc] initWithFrame:
                              CGRectMake(xOrigin, 0,
                                         _roomImageScrollView.frame.size.width,
                                         _roomImageScrollView.frame.size.height)];
        Photo *photo = [_meetingRoom.photo objectAtIndex:i];
        image.image = photo.image;
        image.contentMode = UIViewContentModeScaleAspectFit;
        [_roomImageScrollView addSubview:image];
    }
    
    //set the scroll view content size
    _roomImageScrollView.contentSize = CGSizeMake(_roomImageScrollView.frame.size.width * _meetingRoom.photo.count, _roomImageScrollView.frame.size.height);
    _imagePageControl.numberOfPages = _meetingRoom.photo.count;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (Service *service in _meetingRoom.services) {
        [tempArray addObject:service];
    }
    
    roomDetailsItems = [[NSArray alloc] initWithArray:tempArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = _meetingRoom.name;
}


#pragma mark -
#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _roomImageScrollView.frame.size.width;
    int page = floor((_roomImageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _imagePageControl.currentPage = page;
}


#pragma mark - UICollectionViewDelegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [roomDetailsItems count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RoomDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomDetailsCollectionViewCell" forIndexPath:indexPath];
    Service *service = [roomDetailsItems objectAtIndex:indexPath.row];
    MenuItem *detail = [[MenuItem alloc]initWithTitle:service.name andIcon:service.photo.image];
    [cell setRoomDetailItem:detail];
    
    return cell;
}


#pragma mark -
#pragma mark - UIInterfaceOrientation Methods

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
