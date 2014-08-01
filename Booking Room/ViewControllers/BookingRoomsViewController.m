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
        copyListOfItems = [[NSMutableArray alloc] init];
        searching = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MeetingRoom *itemOne = [[MeetingRoom alloc] initWithTitle :NSLocalizedString(@"MeetingRoom1", @"") andDetails:NSLocalizedString(@"Floor1", @"") andIcon:[UIImage imageNamed:@"Room1"]];
    MeetingRoom *itemTwo = [[MeetingRoom alloc] initWithTitle:NSLocalizedString(@"MeetingRoom2", @"") andDetails:NSLocalizedString(@"Floor2", @"") andIcon:[UIImage imageNamed:@"Room2"]];
    MeetingRoom *itemThree = [[MeetingRoom alloc] initWithTitle:NSLocalizedString(@"MeetingRoom3", @"") andDetails:NSLocalizedString(@"Floor3", @"") andIcon:[UIImage imageNamed:@"Room3"]];
    MeetingRoom *itemFour = [[MeetingRoom alloc] initWithTitle:NSLocalizedString(@"MeetingRoom4", @"") andDetails:NSLocalizedString(@"Floor4", @"") andIcon:[UIImage imageNamed:@"Room4"]];
    meetingRoomItems = [[NSArray alloc] initWithObjects:itemOne, itemTwo, itemThree, itemFour, nil];
    
    // SearchBar initialize
    searching = NO;
    _searchBar.showsCancelButton = NO;
    copyListOfItems = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_searchBar setText:@""];
    [_searchBar resignFirstResponder];
    [_searchBar setShowsCancelButton:NO animated:YES];
    
    //method reload table and clear searching
    searching = NO;
    [_bookingRoomTable reloadData];
}


#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    if (searching) {
        emptyLabel.text = ([copyListOfItems count] == 0) ? NSLocalizedString(@"RoomEmptySearch", @"") : @"";
        emptyLabel.hidden = ([copyListOfItems count] == 0) ? NO : YES;
        return copyListOfItems.count;
    } else {
        emptyLabel.text = ([meetingRoomItems count] == 0) ? NSLocalizedString(@"RoomEmptySearch", @"") : @"";
        emptyLabel.hidden = ([meetingRoomItems count] == 0) ? NO : YES;
        return meetingRoomItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookingRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingRoomCell"];
    
    // Customizes the selection color
    UIView *cellView = [[UIView alloc] initWithFrame:cell.frame];
    cellView.backgroundColor = [UIColor colorWithRed:131.0/255.0 green:224.0/255.0 blue:84.0/255.0 alpha:0.6f];
    [cell setSelectedBackgroundView:cellView];
    
    if (searching) {
        [cell setMeetingRoomItem:[copyListOfItems objectAtIndex:indexPath.row]];
    } else {
        [cell setMeetingRoomItem:[meetingRoomItems objectAtIndex:indexPath.row]];
    }
    
	return cell;
}


#pragma mark -
#pragma mark - UISearchBar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (!_searchBar.showsCancelButton) {
        _searchBar.showsCancelButton = YES;
        [_bookingRoomTable setHidden:NO];
    }
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    // Removes all objects first.
    [copyListOfItems removeAllObjects];
    
    if([searchText length] > 0) {
        searching = YES;
        [self searchString:theSearchBar.text];
        [_bookingRoomTable setHidden:NO];
    } else {
        searching = NO;
    }
    
    [_bookingRoomTable reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
    searching = NO;
    _searchBar.text = @"";
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
    [_bookingRoomTable reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
}

- (void)searchString:(NSString *)searchText {
    NSMutableArray *searchArray = [[NSMutableArray alloc] initWithArray:meetingRoomItems];
    NSString *nameTemp;
    
    for (int x = 0; x < [searchArray count]; x++) {
        if ([[searchArray objectAtIndex:x] isKindOfClass:[MeetingRoom class]]) {
            MeetingRoom *room = [searchArray objectAtIndex:x];
            nameTemp = (room.title != nil) ? [[NSString alloc] initWithString:room.title] : @"";
            NSRange nameResultsRange = [nameTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (nameResultsRange.length > 0 && ![copyListOfItems containsObject:room]) {
                [copyListOfItems addObject:room];
            }
        }
    }
    
    searchArray = nil;
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


#pragma mark -
#pragma mark - UIInterfaceOrientation Methods

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
