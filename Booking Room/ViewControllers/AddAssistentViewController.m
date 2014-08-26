//
//  AddAssistentViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "AddAssistentViewController.h"
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;

@interface AddAssistentViewController ()

@end

@implementation AddAssistentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    copyListOfItems = [[NSMutableArray alloc] init];
    [self customComponent];
    
    // Applies the blur effect to the background image
    _background.image = _backgroundImage;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0L), ^{
        UIImage *blur = [_backgroundImage applyLightEffect];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CATransition *transition = [CATransition animation];
            
            transition.duration = 0.2;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransition;
            
            [self.background.layer addAnimation:transition forKey:nil];
            self.background.layer.contents = (id)blur.CGImage;
            
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        });
    });
    
    Person *itemOne = [[Person alloc] initWithIdentifier:0 name:@"Veronica Hernandez Duran" email:@"vero@hotmail.com" photo:nil department:@"Apss" company:@"Sellcom" position:@"Sistemas" car:nil];
    Person *itemTwo = [[Person alloc] initWithIdentifier:0 name:@"Emilio Rojas Gomez" email:@"rd56_02@gmail.com" photo:nil department:@"Ventas" company:@"Palacio de Hierro" position:@"Ventas" car:nil];
    
    assistantItems = [[NSMutableArray alloc] initWithObjects:itemOne, itemTwo, nil];
    
    // Attach method to segment control
    _segmentAssistants.selectedSegmentIndex = 0;
    [_segmentAssistants addTarget:self
                           action:@selector(didChangeSegmentControl:)
                 forControlEvents:UIControlEventValueChanged];
    [self didChangeSegmentControl:_segmentAssistants];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closePopOver:(id)sender {
    self.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark UISegmentedControl Methods

- (void)didChangeSegmentControl:(UISegmentedControl *)control {
    if (control.selectedSegmentIndex == 0) {
        //NSLog(@"Sellcom assistants");
        _viewSellcom.hidden = NO;
        _viewCreateAssistant.hidden = YES;
    } else {
        //NSLog(@"External assistants");
        _viewSellcom.hidden = YES;
        _viewCreateAssistant.hidden = NO;
    }
    [self dismissKeyboard:nil];
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
    [_sellcomTable reloadData];
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
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
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


#pragma mark -
#pragma mark - UISearchBar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (!_searchBar.showsCancelButton) {
        _searchBar.showsCancelButton = YES;
        [_sellcomTable setHidden:NO];
    }
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    // Removes all objects first.
    [copyListOfItems removeAllObjects];
    
    if([searchText length] > 0) {
        searching = YES;
        [self searchString:theSearchBar.text];
        [_sellcomTable setHidden:NO];
    } else {
        searching = NO;
    }
    
    [_sellcomTable reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
    searching = NO;
    _searchBar.text = @"";
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
    [_sellcomTable reloadData];
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


#pragma mark - UITextFieldDelegate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0) {
        heightFraction = 0.0;
    } else if (heightFraction > 1.0) {
        heightFraction = 1.0;
    }
    
    animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
    [_nameTextField resignFirstResponder];
    [_emailTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_companyTextField resignFirstResponder];
}


#pragma mark - Custom Methods

- (void)customComponent {
    // SearchBar initialize
    searching = NO;
    _searchBar.showsCancelButton = NO;
    
    // Sets the TableViewFooter
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 1.0, 1.0, 1.0)];
    footerView.backgroundColor = [UIColor clearColor];
    _sellcomTable.tableFooterView = footerView;
    
    // Customize the UITextField's
    _nameTextField.borderStyle = UITextBorderStyleLine;
    _nameTextField.layer.cornerRadius = 8.0f;
    _nameTextField.layer.masksToBounds = YES;
    _nameTextField.layer.borderColor = [[UIColor whiteColor] CGColor];
    _nameTextField.layer.borderWidth = 1.0f;
    _nameTextField.delegate = self;
    
    _companyTextField.borderStyle = UITextBorderStyleLine;
    _companyTextField.layer.cornerRadius = 8.0f;
    _companyTextField.layer.masksToBounds = YES;
    _companyTextField.layer.borderColor = [[UIColor whiteColor] CGColor];
    _companyTextField.layer.borderWidth = 1.0f;
    _companyTextField.delegate = self;
    
    _emailTextField.borderStyle = UITextBorderStyleLine;
    _emailTextField.layer.cornerRadius = 8.0f;
    _emailTextField.layer.masksToBounds = YES;
    _emailTextField.layer.borderColor = [[UIColor whiteColor] CGColor];
    _emailTextField.layer.borderWidth = 1.0f;
    _emailTextField.delegate = self;
    
    _phoneTextField.borderStyle = UITextBorderStyleLine;
    _phoneTextField.layer.cornerRadius = 8.0f;
    _phoneTextField.layer.masksToBounds = YES;
    _phoneTextField.layer.borderColor = [[UIColor whiteColor] CGColor];
    _phoneTextField.layer.borderWidth = 1.0f;
    _phoneTextField.delegate = self;
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
