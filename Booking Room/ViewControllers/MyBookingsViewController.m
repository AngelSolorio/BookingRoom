//
//  ReservacionesViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "MyBookingsViewController.h"

@interface MyBookingsViewController ()

@end

@implementation MyBookingsViewController

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

    Booking *itemOne = [[Booking alloc] initWithIdentifier:0 title:@"Junta 1" startDate:[NSDate date] endDate:[NSDate date] owner:[[Person alloc]init] assistants:nil createAt:[NSDate date] meetingRoom:nil priority:0 status:nil statusDate:[NSDate date]];
    Booking *itemTwo = [[Booking alloc] initWithIdentifier:0 title:@"Junta 2" startDate:[NSDate date] endDate:[NSDate date] owner:[[Person alloc]init] assistants:nil createAt:[NSDate date] meetingRoom:nil priority:[NSNumber numberWithInt:1] status:nil statusDate:[NSDate date]];
    Booking *itemThree = [[Booking alloc] initWithIdentifier:0 title:@"Junta 3" startDate:[NSDate date] endDate:[NSDate date] owner:[[Person alloc]init] assistants:nil createAt:[NSDate date] meetingRoom:nil priority:[NSNumber numberWithInt:2] status:nil statusDate:[NSDate date]];
    Booking *itemFour = [[Booking alloc] initWithIdentifier:0 title:@"Junta 4" startDate:[NSDate date] endDate:[NSDate date] owner:[[Person alloc]init] assistants:nil createAt:[NSDate date] meetingRoom:nil priority:[NSNumber numberWithInt:3] status:nil statusDate:[NSDate date]];
    
    myBookingsItems = [[NSMutableArray alloc] initWithObjects:itemOne, itemTwo, itemThree, itemFour, nil];
    
    // SearchBar initialize
    searching = NO;
    _searchBar.showsCancelButton = NO;
    copyListOfItems = [[NSMutableArray alloc] init];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // Shows the Navigation Bar
    [self.navigationController setNavigationBarHidden:NO];
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
    [_myBookingsTable reloadData];
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
        emptyLabel.text = ([myBookingsItems count] == 0) ? NSLocalizedString(@"EmptySearch", @"") : @"";
        emptyLabel.hidden = ([myBookingsItems count] == 0) ? NO : YES;
        return myBookingsItems.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyBookingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBookingCell"];
    
    // Customizes the selection color
    UIView *cellView = [[UIView alloc] initWithFrame:cell.frame];
    cellView.backgroundColor = [UIColor colorWithRed:131.0/255.0 green:224.0/255.0 blue:84.0/255.0 alpha:0.6f];
    [cell setSelectedBackgroundView:cellView];
    
    if (searching) {
        [cell setBooking:[copyListOfItems objectAtIndex:indexPath.row]];
    } else {
        [cell setBooking:[myBookingsItems objectAtIndex:indexPath.row]];
    }
    
    return cell;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [myBookingsItems removeObjectAtIndex:indexPath.row];
        
        if (searching) {
            [copyListOfItems removeObjectAtIndex:indexPath.row];
        }
        
        [_myBookingsTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark -
#pragma mark - UISearchBar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (!_searchBar.showsCancelButton) {
        _searchBar.showsCancelButton = YES;
        [_myBookingsTable setHidden:NO];
    }
}


- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    // Removes all objects first.
    [copyListOfItems removeAllObjects];
    
    if([searchText length] > 0) {
        searching = YES;
        [self searchString:theSearchBar.text];
        [_myBookingsTable setHidden:NO];
    } else {
        searching = NO;
    }
    
    [_myBookingsTable reloadData];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
    searching = NO;
    _searchBar.text = @"";
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
    [_myBookingsTable reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
}


- (void)searchString:(NSString *)searchText {
    NSMutableArray *searchArray = [[NSMutableArray alloc] initWithArray:myBookingsItems];
    NSString *nameTemp;
    
    for (int x = 0; x < [searchArray count]; x++) {
        if ([[searchArray objectAtIndex:x] isKindOfClass:[Booking class]]) {
            Booking *booking = [searchArray objectAtIndex:x];
            nameTemp = (booking.title != nil) ? [[NSString alloc] initWithString:booking.title] : @"";
            NSRange nameResultsRange = [nameTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (nameResultsRange.length > 0 && ![copyListOfItems containsObject:booking]) {
                [copyListOfItems addObject:booking];
            }
        }
    }
    
    searchArray = nil;
}


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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UIBarButtonItem Methods

- (IBAction)editMyBookings:(id)sender {
    if (_myBookingsTable.editing) {
        [super setEditing:NO animated:YES];
        [_myBookingsTable setEditing:NO animated:YES];
        _editButton.title = NSLocalizedString(@"EditButton", nil);
    } else {
        [super setEditing:YES animated:YES];
        [_myBookingsTable setEditing:YES animated:YES];
        _editButton.title = NSLocalizedString(@"DoneButton", nil);
    }

}
@end
