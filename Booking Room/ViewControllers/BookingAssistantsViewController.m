//
//  BookingAssistantsViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "BookingAssistantsViewController.h"

@interface BookingAssistantsViewController ()

@end

@implementation BookingAssistantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *itemOne = [[Person alloc] initWithIdentifier:0 name:@"Veronica Hernandez Duran" email:@"vero@hotmail.com" photo:nil department:@"Apss" company:@"Sellcom" position:@"Sistemas" car:nil];
    Person *itemTwo = [[Person alloc] initWithIdentifier:0 name:@"Emilio Rojas Gomez" email:@"rd56_02@gmail.com" photo:nil department:@"Ventas" company:@"Palacio de Hierro" position:@"Ventas" car:nil];
    
    assistantItems = [[NSMutableArray alloc] initWithObjects:itemOne, itemTwo, nil];
    
    // Sets the TableViewFooter
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 1.0, 1.0, 1.0)];
    footerView.backgroundColor = [UIColor clearColor];
    _assistantsTable.tableFooterView = footerView;
    
    // SearchBar initialize
    searching = NO;
    _searchBar.showsCancelButton = NO;
    _searchBar.frame = CGRectMake(0, _searchBar.frame.origin.y, _searchBar.frame.size.width - 30,  _searchBar.frame.size.height);
    copyListOfItems = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextStep:(id)sender {
    [self.stepsController showNextStep];
}

- (IBAction)addAssistant:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddAssistentViewController *modalVC = [storyboard instantiateViewControllerWithIdentifier:@"AddAssistantView"];
    [modalVC setBackgroundImage:[Utility getScreenshot:self.parentViewController.view]];
    [self presentViewController:modalVC animated:NO completion:NULL];
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
    [_assistantsTable reloadData];
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
        emptyLabel.text = ([assistantItems count] == 0) ? NSLocalizedString(@"EmptySearch", @"") : @"";
        emptyLabel.hidden = ([assistantItems count] == 0) ? NO : YES;
        return assistantItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AssistantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssistantCell"];
    
    // Customizes the selection color
    UIView *cellView = [[UIView alloc] initWithFrame:cell.frame];
    cellView.backgroundColor = [UIColor colorWithRed:131.0/255.0 green:224.0/255.0 blue:84.0/255.0 alpha:0.6f];
    [cell setSelectedBackgroundView:cellView];
    
    if (searching) {
        [cell setPersonItem:[copyListOfItems objectAtIndex:indexPath.row]];
    } else {
        [cell setPersonItem:[assistantItems objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [assistantItems removeObjectAtIndex:indexPath.row];
        
        if (searching) {
            [copyListOfItems removeObjectAtIndex:indexPath.row];
        }
        
        [_assistantsTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark -
#pragma mark - UISearchBar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (!_searchBar.showsCancelButton) {
        _addPerson.enabled = FALSE;
        _addPerson.alpha = 0;
        _searchBar.frame = CGRectMake(0, _searchBar.frame.origin.y, _searchBar.frame.size.width + 30,  _searchBar.frame.size.height);
        _searchBar.showsCancelButton = YES;
        [_assistantsTable setHidden:NO];
    }
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    // Removes all objects first.
    [copyListOfItems removeAllObjects];
    
    if([searchText length] > 0) {
        searching = YES;
        [self searchString:theSearchBar.text];
        [_assistantsTable setHidden:NO];
    } else {
        searching = NO;
    }
    
    [_assistantsTable reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
    searching = NO;
    _searchBar.text = @"";
    _searchBar.showsCancelButton = NO;
    _addPerson.enabled = TRUE;
    _addPerson.alpha = 1;
    _searchBar.frame = CGRectMake(0, _searchBar.frame.origin.y, _searchBar.frame.size.width - 30,  _searchBar.frame.size.height);
    [_searchBar resignFirstResponder];
    [_assistantsTable reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
}

- (void)searchString:(NSString *)searchText {
    NSMutableArray *searchArray = [[NSMutableArray alloc] initWithArray:assistantItems];
    NSString *nameTemp;
    
    for (int x = 0; x < [searchArray count]; x++) {
        if ([[searchArray objectAtIndex:x] isKindOfClass:[Person class]]) {
            Person *room = [searchArray objectAtIndex:x];
            nameTemp = (room.name != nil) ? [[NSString alloc] initWithString:room.name] : @"";
            NSRange nameResultsRange = [nameTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (nameResultsRange.length > 0 && ![copyListOfItems containsObject:room]) {
                [copyListOfItems addObject:room];
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

@end
