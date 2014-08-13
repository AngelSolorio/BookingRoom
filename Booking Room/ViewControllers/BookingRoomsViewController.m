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
    Service *screen = [[Service alloc]initWithIdentifier:0 name:@"Screen" value:[NSNumber numberWithInt:1] photo:[[Photo alloc]initWithImage:[UIImage imageNamed:@"Screen"]]];
    MeetingRoom *itemOne = [[MeetingRoom alloc]initWithIdentifier:0 name:@"Sala de Juntas 1" location:@"Piso 1" photo:[[NSMutableArray alloc] initWithObjects:[[Photo alloc] initWithImage:[UIImage imageNamed:@"room1front.png"]], nil] services:[[NSMutableArray alloc] initWithObjects:screen, screen, nil] ];
    MeetingRoom *itemTwo = [[MeetingRoom alloc]initWithIdentifier:0 name:@"Sala de Juntas 2" location:@"Piso 1" photo:[[NSMutableArray alloc] initWithObjects:[[Photo alloc] initWithImage:[UIImage imageNamed:@"room2front.png"]], nil] services:[[NSMutableArray alloc] initWithObjects:screen, screen, screen, nil] ];
    MeetingRoom *itemThree = [[MeetingRoom alloc]initWithIdentifier:0 name:@"Sala de Juntas 3" location:@"Piso 2" photo:[[NSMutableArray alloc] initWithObjects:[[Photo alloc]initWithImage:[UIImage imageNamed:@"room3front.png"]], nil] services:[[NSMutableArray alloc] initWithObjects:screen, nil] ];
    MeetingRoom *itemFour = [[MeetingRoom alloc]initWithIdentifier:0 name:@"Sala de Juntas 4" location:@"Piso 2" photo:[[NSMutableArray alloc] initWithObjects:[[Photo alloc] initWithImage:[UIImage imageNamed:@"room2front.png"]], nil] services:[[NSMutableArray alloc] initWithObjects:screen, screen, screen, screen, nil] ];
    
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
        emptyLabel.text = ([copyListOfItems count] == 0) ? NSLocalizedString(@"EmptySearch", @"") : @"";
        emptyLabel.hidden = ([copyListOfItems count] == 0) ? NO : YES;
        return copyListOfItems.count;
    } else {
        emptyLabel.text = ([meetingRoomItems count] == 0) ? NSLocalizedString(@"EmptySearch", @"") : @"";
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
            nameTemp = (room.name != nil) ? [[NSString alloc] initWithString:room.name] : @"";
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
        [detailRoom setMeetingRoom:btn.meetingRoomItem];
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
