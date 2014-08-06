//
//  LeftMenuViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 22/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MenuTableViewCell.h"

#define FacebookAppIdKey @"1518570525042067"

@implementation LeftMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Creates the menu items
    MenuItem *itemOne = [[MenuItem alloc] initWithTitle:NSLocalizedString(@"Home", @"") andIcon:[UIImage imageNamed:@"Home"]];
    MenuItem *itemTwo = [[MenuItem alloc] initWithTitle:NSLocalizedString(@"MyBookings", @"") andIcon:[UIImage imageNamed:@"Reservaciones"]];
    MenuItem *itemThree = [[MenuItem alloc] initWithTitle:NSLocalizedString(@"MeetingBookingRooms", @"") andIcon:[UIImage imageNamed:@"Salas"]];
    MenuItem *itemFour = [[MenuItem alloc] initWithTitle:NSLocalizedString(@"Suggestions", @"")andIcon:[UIImage imageNamed:@"Comentarios"]];
    MenuItem *itemFive = [[MenuItem alloc] initWithTitle:NSLocalizedString(@"LogOut", @"") andIcon:[UIImage imageNamed:@"Logout"]];
    menuItems = [[NSArray alloc] initWithObjects:itemOne, itemTwo, itemThree, itemFour, itemFive, nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"homeController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"myBookingsController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"bookingRoomsController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"suggestionsController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 4:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}


#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return [menuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    [cell setMenuItem:[menuItems objectAtIndex:indexPath.row]];
    
    // Customizes the selection color
    UIView *cellView = [[UIView alloc] initWithFrame:cell.frame];
    cellView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6f];
    [cell setSelectedBackgroundView:cellView];
    
    return cell;
}


#pragma mark - UIInterfaceOrientation Methods

- (BOOL)shouldAutorotate {
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
