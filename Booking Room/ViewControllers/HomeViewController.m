//
//  HomeViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "HomeViewController.h"

NSString *kCellID = @"MeetingRoomCellID";

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Initizalize variables
    customGreenColor = [UIColor colorWithRed:150/255. green:209/255. blue:124/255. alpha:1.0];
    selectedDate = [NSDate date];

    MeetingRoom *room1 = [[MeetingRoom alloc] init];
    room1.icon = [UIImage imageNamed:@"Room1"];
    room1.identifier = [NSNumber numberWithInteger:1];

    MeetingRoom *room2 = [[MeetingRoom alloc] init];
    room2.icon = [UIImage imageNamed:@"Room2"];
    room2.identifier = [NSNumber numberWithInteger:2];

    MeetingRoom *room3 = [[MeetingRoom alloc] init];
    room3.icon = [UIImage imageNamed:@"Room3"];
    room3.identifier = [NSNumber numberWithInteger:3];

    MeetingRoom *room4 = [[MeetingRoom alloc] init];
    room4.icon = [UIImage imageNamed:@"Room4"];
    room4.identifier = [NSNumber numberWithInteger:4];
    
    meetingRoomsArray = [[NSMutableArray alloc] initWithObjects:room1, room2, room3, room4, nil];

    // Selects the first meeting room
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [_meetingRoomsCollection selectItemAtIndexPath:index animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // Shows the Navigation Bar
    [self.navigationController setNavigationBarHidden:NO];

    // Setes the title
    self.title = NSLocalizedString(@"Home_Title", nil);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [meetingRoomsArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MeetingRoomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];;

    MeetingRoom *currentMeetingRoom = [meetingRoomsArray objectAtIndex:indexPath.row];
    [cell setMeetingRoom:currentMeetingRoom];

    return cell;
}


#pragma mark - UICollectionViewDelegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selectedMeetingRoom = indexPath.row;
}


#pragma mark - IBActions Methods

- (IBAction)previousMonth:(id)sender {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:-1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    selectedDate = [calendar dateByAddingComponents:dateComponents toDate:selectedDate options:0];
    [self displayDate:selectedDate];
}


- (IBAction)nextMonth:(id)sender {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    selectedDate = [calendar dateByAddingComponents:dateComponents toDate:selectedDate options:0];
    [self displayDate:selectedDate];
}


#pragma mark - Custom Methods

- (void)displayDate:(NSDate *)date {
    NSLocale *currentLocale;
    if ([[Utility getCurrentLanguageCode] isEqualToString:@"en"]) {
        currentLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    } else {
        currentLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_MX"];
    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:currentLocale];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"MMMM, yyyy"];
    NSString *stringDate = [formatter stringFromDate:date];
    _dateLabel.text = [stringDate capitalizedStringWithLocale:currentLocale];
}


@end
