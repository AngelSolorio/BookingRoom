//
//  SalasViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "BookingRoomsViewController.h"
#import "RoomDetailsViewController.h"

@interface BookingRoomsViewController ()

@end

@implementation BookingRoomsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MeetingRoom *itemOne = [[MeetingRoom alloc] initWithTitle :NSLocalizedString(@"MeetingRoom1", @"") andDetails:NSLocalizedString(@"DetailsMeetingRoom", @"") andIcon:[UIImage imageNamed:@"Room1"]];
    MeetingRoom *itemTwo = [[MeetingRoom alloc] initWithTitle:NSLocalizedString(@"MeetingRoom2", @"") andDetails:NSLocalizedString(@"DetailsMeetingRoom", @"") andIcon:[UIImage imageNamed:@"Room2"]];
    MeetingRoom *itemThree = [[MeetingRoom alloc] initWithTitle:NSLocalizedString(@"MeetingRoom3", @"") andDetails:NSLocalizedString(@"DetailsMeetingRoom", @"") andIcon:[UIImage imageNamed:@"Room3"]];
    MeetingRoom *itemFour = [[MeetingRoom alloc] initWithTitle:NSLocalizedString(@"MeetingRoom4", @"") andDetails:NSLocalizedString(@"DetailsMeetingRoom", @"") andIcon:[UIImage imageNamed:@"Room4"]];
    meetingRoomItems = [[NSArray alloc] initWithObjects:itemOne, itemTwo, itemThree, itemFour, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return meetingRoomItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookingRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingRoomCell"];
    [cell setMeetingRoomItem:[meetingRoomItems objectAtIndex:indexPath.row]];
    
    // Customizes the selection color
    UIView *cellView = [[UIView alloc] initWithFrame:cell.frame];
    cellView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6f];
    [cell setSelectedBackgroundView:cellView];
    
	return cell;
}


#pragma mark -
#pragma mark - UIStoryBoard Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"roomToDetailRoom"]) {
        BookingRoomTableViewCell *btn = (BookingRoomTableViewCell *)sender;
        RoomDetailsViewController *detailRoom = [segue destinationViewController];
        [detailRoom setTitleView:btn.nameBooking.text];
    }
}

@end
