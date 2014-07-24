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

- (id)initWithTitleName:(NSString *)title {
    self = [super init];
    if (self) {
        _titleView = title;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 3; i++) {
        CGFloat xOrigin = i * _roomImageScrollView.frame.size.width;
        UIImageView *image = [[UIImageView alloc] initWithFrame:
                              CGRectMake(xOrigin, 0,
                                         _roomImageScrollView.frame.size.width,
                                         _roomImageScrollView.frame.size.height)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"room%dfront.png",i+1]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [_roomImageScrollView addSubview:image];
    }
    
    //set the scroll view content size
    _roomImageScrollView.contentSize = CGSizeMake(_roomImageScrollView.frame.size.width * 3, _roomImageScrollView.frame.size.height);
    
    MenuItem *itemOne = [[MenuItem alloc] initWithTitle:@"Screen 42 inch 16x9 display" andIcon:[UIImage imageNamed:@"Screen"]];
    MenuItem *itemTwo = [[MenuItem alloc] initWithTitle:@"Projector resolution 1280x720" andIcon:[UIImage imageNamed:@"Projector"]];
    MenuItem *itemThree = [[MenuItem alloc] initWithTitle:@"Stationery" andIcon:[UIImage imageNamed:@"Stationery"]];
    
    roomDetailsItems = [[NSArray alloc] initWithObjects:itemOne, itemTwo, itemThree, nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = _titleView;
}


#pragma mark -
#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _roomImageScrollView.frame.size.width;
    int page = floor((_roomImageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _imagePageControl.currentPage = page;
}


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return roomDetailsItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailsCell"];
    [cell setRoomDetailItem:[roomDetailsItems objectAtIndex:indexPath.row]];
    
    // Customizes the selection color
    UIView *cellView = [[UIView alloc] initWithFrame:cell.frame];
    cellView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6f];
    [cell setSelectedBackgroundView:cellView];
    
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
