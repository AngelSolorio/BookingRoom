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
    
    // Creates the activity indicator
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.indicator];
    self.navigationItem.rightBarButtonItem = item;
    meetingRoomItems = [[NSArray alloc] init];

    // Sets the TableViewFooter
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 1.0, 1.0, 1.0)];
    footerView.backgroundColor = [UIColor clearColor];
    _bookingRoomTable.tableFooterView = footerView;
    
    // SearchBar initialize
    searching = NO;
    _searchBar.showsCancelButton = NO;
    copyListOfItems = [[NSMutableArray alloc] init];
    
    // ---- Gets the MeetingRooms from the Web Service using the AFNetworking Framework ----
    [self.indicator startAnimating];
    
    [[WebService sharedClient] getAllMeetingRooms:^(NSDictionary *results, NSError *error){
        // Validates the response
        if ([[results valueForKey:@"success"] boolValue]) {
            NSLog(@"EVENT: %@", NSLocalizedString(@"Login_Success", nil));
            [self performSelectorInBackground:@selector(changesToDatabase:) withObject:results];
        } else if (error.code == 401) { // Invalid User Token
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Suggestion_TitleLabel", nil)
                                        message:NSLocalizedString(@"TokenInvalid", nil)
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OkButton", nil)
                              otherButtonTitles: nil] show];
            NSLog(@"EVENT: %@", NSLocalizedString(@"TokenInvalid", nil));
            [self.indicator stopAnimating];
        } else {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Suggestion_TitleLabel", nil)
                                        message:NSLocalizedString(@"Connection_Error", nil)
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OkButton", nil)
                              otherButtonTitles: nil]
             show];
            NSLog(@"EVENT: %@", NSLocalizedString(@"Connection_Error", nil));
            [self.indicator stopAnimating];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


#pragma mark - Web Service Response

- (void)changesToDatabase:(NSDictionary *)results {
    if ([[results valueForKey:@"meeting_rooms"] count] > 0) {
        NSMutableArray *item = [[NSMutableArray alloc] init];
        
        for (MeetingRoom *meetingRoom in [results valueForKey:@"meeting_rooms"]) {
            [item addObject:meetingRoom];
        }
        
        meetingRoomItems = [[NSArray alloc] initWithArray:item];
        [_bookingRoomTable reloadData];
    }
    
    // Stops the activity indicator
    [self.indicator stopAnimating];
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
    
    // Customizes accessoryView color
    DTCustomColoredAccessory *accessory = [DTCustomColoredAccessory accessoryWithColor:[UIColor colorWithRed:89.0/255.0f green:89.0/255.0f blue:89.0/255.0f alpha:1.0f]];
    accessory.highlightedColor = [UIColor whiteColor];
    cell.accessoryView =accessory;
    
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
