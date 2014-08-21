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

- (id)initWithMeetingRoom:(MeetingRoom *)aMeetingRoom {
    self = [super init];
    if (self) {
        self.meetingRoom = aMeetingRoom;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Creates the activity indicator
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.indicator];
    self.navigationItem.rightBarButtonItem = item;
    
    // Add images into ScrollView
    int cont = 0;
    for ( Photo *photoMeeting in _meetingRoom.photo) {
        CGFloat xOrigin = cont * _roomImageScrollView.frame.size.width;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(xOrigin, 0, _roomImageScrollView.frame.size.width, _roomImageScrollView.frame.size.height)];
        
        if (photoMeeting.image) {
            imageView.image = photoMeeting.image;
        } else {
            UIImage *imageSave = [Utility getImageFromFileSystem:[NSString stringWithFormat:@"%@_%@.png",_meetingRoom.name, photoMeeting.identifier]
                                                        inFolder:@"MeetingRoom"];
            if (imageSave) {
                imageView.image = imageSave;
            } else {
                [imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:photoMeeting.url]]
                                 placeholderImage:[UIImage imageNamed:@"Room1"]
                                          success:^(NSURLRequest *request , NSHTTPURLResponse *response , UIImage *image ){
                                              photoMeeting.image = image ? image : [UIImage imageNamed:@"Room1"];
                                              UIImageView *imageView = [[_roomImageScrollView subviews] objectAtIndex:cont];
                                              imageView.image = image ? image : [UIImage imageNamed:@"Room1"];
                                              [Utility saveImageToFileSystem:image withFileName:[NSString stringWithFormat:@"%@_%@.png",_meetingRoom.name, photoMeeting.identifier]
                                                                    inFolder:@"MeetingRoom"];
                                              NSLog(@"Loaded successfully: %ld", (long)[response statusCode]);
                                          }
                                          failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                              NSLog(@"failed loading: %@", error);
                                              NSLog(@"Error loading dish picture: %@", error.description);
                                          }
                 ];
            }
        }
        
        [_roomImageScrollView addSubview:imageView];
        cont ++;
    }
    
    //set the scroll view content size
    _roomImageScrollView.contentSize = CGSizeMake(_roomImageScrollView.frame.size.width * _meetingRoom.photo.count, _roomImageScrollView.frame.size.height);
    _imagePageControl.numberOfPages = _meetingRoom.photo.count;
    
    // ---- Gets the MeetingRooms from the Web Service using the AFNetworking Framework ----
    [self.indicator startAnimating];
    
    [[WebService sharedClient] getDetailsMeetingRoomById:[_meetingRoom.identifier intValue]
                                              completion:^(NSDictionary *results, NSError *error) {
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = _meetingRoom.name;
}


#pragma BackButton Method

- (IBAction)backButtonTouch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - PageControl Response

- (IBAction)changePage:(id)sender {
    UIPageControl *pager = sender;
    int page = (int) pager.currentPage;
    CGRect frame = _roomImageScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [_roomImageScrollView scrollRectToVisible:frame animated:YES];
}


#pragma mark - Web Service Response

- (void)changesToDatabase:(NSDictionary *)results {
    if ([[results valueForKey:@"meeting_room"] count] > 0) {
        NSMutableArray *item = [[NSMutableArray alloc] init];
        
        for (Service *meetingRoom in [results valueForKey:@"meeting_room"]) {
            [item addObject:meetingRoom];
        }
        
        roomDetailsItems = [[NSArray alloc] initWithArray:item];
        [_roomDetailsCollectionView reloadData];
    }
    
    // Stops the activity indicator
    [self.indicator stopAnimating];
}


#pragma mark -
#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _roomImageScrollView.frame.size.width;
    int page = floor((_roomImageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _imagePageControl.currentPage = page;
}


#pragma mark - UICollectionViewDelegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [roomDetailsItems count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RoomDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomDetailsCollectionViewCell" forIndexPath:indexPath];
    Service *service = [roomDetailsItems objectAtIndex:indexPath.row];
    [cell setRoomDetailItem:service];
    
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

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
