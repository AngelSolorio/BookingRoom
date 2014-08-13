//
//  LeftMenuViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 22/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "LeftMenuViewController.h"

#define FacebookAppIdKey        @"1518570525042067"
#define TwitterAppIdKey         @"1wG8eh4e6GNZXCKCdw9ueyeF1"
#define TwitterAppIdKeySecret   @"ETl8AAULAGUCOqOwgSyMy9JYPc09JVsktGvhOSEDpL5MOSx0eW"

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
    MenuItem *itemOne = [[MenuItem alloc] initWithTitle:NSLocalizedString(@"Home", @"")
                                                andIcon:[UIImage imageNamed:@"Home"]];
    MenuItem *itemTwo = [[MenuItem alloc] initWithTitle:NSLocalizedString(@"MyBookings", @"")
                                                andIcon:[UIImage imageNamed:@"Reservaciones"]];
    MenuItem *itemThree = [[MenuItem alloc] initWithTitle:NSLocalizedString(@"MeetingBookingRooms", @"")
                                                  andIcon:[UIImage imageNamed:@"Salas"]];
    MenuItem *itemFour = [[MenuItem alloc] initWithTitle:NSLocalizedString(@"Suggestions", @"")
                                                 andIcon:[UIImage imageNamed:@"Comentarios"]];
    MenuItem *itemFive = [[MenuItem alloc] initWithTitle:NSLocalizedString(@"LogOut", @"")
                                                 andIcon:[UIImage imageNamed:@"Logout"]];
    MenuItem *itemSix = [[MenuItem alloc] initWithTitle:NSLocalizedString(@"About", @"")
                                                 andIcon:[UIImage imageNamed:@"About"]];
    menuItems = [[NSArray alloc] initWithObjects:itemOne, itemTwo, itemThree, itemFour, itemFive, itemSix, nil];

    // Configures the long press over the user picture
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.numberOfTapsRequired = 0;
    longPress.numberOfTouchesRequired = 1;
    longPress.minimumPressDuration = .2;
    [_userPicture addGestureRecognizer:longPress];
    
    accountStore = [[ACAccountStore alloc] init];

    [self userLogged];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)userLogged {
    // Sets the user picture and name
    _nameLabel.text = [[FeedUserDefaults name] length] != 0  ? [FeedUserDefaults name] : [FeedUserDefaults user];
    UIImage *picture = [Utility getImageFromFileSystem:[NSString stringWithFormat:@"user_%@.png", [FeedUserDefaults user]]
                                              inFolder:@"People"];
    if (picture) {
        _userPicture.image = picture;
    } else {
        [_userPicture setImageWithString:[FeedUserDefaults user] color:[UIColor whiteColor]];
    }
}


#pragma mark - UIGestureRecognizer Methods

- (void)longPress:(UILongPressGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSArray *items = @[
                           [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"Facebook"]
                                                           title:@"Facebook"],
                           [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"Twitter"]
                                                           title:@"Twitter"],
                           [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"Camera"]
                                                           title:NSLocalizedString(@"Camera", @"")],
                           [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"Iphone"]
                                                           title:NSLocalizedString(@"Device", @"")],
                           [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"EditPhoto"]
                                                           title:NSLocalizedString(@"Edit", @"")],
                           [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"DeletePhoto"]
                                                           title:NSLocalizedString(@"Delete", @"")],
                           [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"Cancel"]
                                                           title:NSLocalizedString(@"Cancel", @"")]
                           ];
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        UILabel *textHeader = [[UILabel alloc] initWithFrame:header.frame];
        textHeader.text = NSLocalizedString(@"LoadProfilePhoto", @"");
        textHeader.font = [UIFont boldSystemFontOfSize:17];
        textHeader.textColor = [UIColor whiteColor];
        textHeader.textAlignment = NSTextAlignmentCenter;
        header.backgroundColor = [UIColor colorWithRed:156.0/255.0f green:250.0/255.0f blue:225.0/255.0f alpha:0.3f];
        [header addSubview:textHeader];
        
        RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, items.count)]];
        av.headerView = header;
        av.highlightColor = [UIColor colorWithRed:156.0/255.0f green:250.0/255.0f blue:225.0/255.0f alpha:0.1f];
        av.delegate = self;
        av.bounces = NO;
        [av showInViewController:self.parentViewController center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
    }
}


#pragma mark -  UITableViewDelegate Methods

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


#pragma mark - UITableViewDatasource Methods

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
    cellView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25f];
    [cell setSelectedBackgroundView:cellView];
    
    return cell;
}


#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    //NSLog(@"Dismissed with item %d: %@", itemIndex, item.title);
    switch (itemIndex) {
        case 0:// facebook
            [self connectFacebook];
            break;
        case 1:// twitter
            [self connectTwitter];
            break;
        case 2: {  // camera
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                _imagePickController  = [[UIImagePickerController alloc] init];
                _imagePickController.sourceType = UIImagePickerControllerSourceTypeCamera;
                _imagePickController.delegate = self;
                _imagePickController.allowsEditing = YES;
                
                CAShapeLayer *circleLayer = [CAShapeLayer layer];
                UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0f, 45.0f, 320.0f, 320.0f)];
                [path2 setUsesEvenOddFillRule:YES];
                [circleLayer setPath:[path2 CGPath]];
                [circleLayer setFillColor:[[UIColor clearColor] CGColor]];
                UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 320, self.view.frame.size.height) cornerRadius:0];
                [path appendPath:path2];
                [path setUsesEvenOddFillRule:YES];
                
                CAShapeLayer *fillLayer = [CAShapeLayer layer];
                fillLayer.path = path.CGPath;
                fillLayer.fillRule = kCAFillRuleEvenOdd;
                fillLayer.fillColor = [UIColor blackColor].CGColor;
                fillLayer.opacity = 0.5;
                [_imagePickController.view.layer addSublayer:fillLayer];
                
                if ([UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceFront ]) {
                    _imagePickController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                } else {
                    _imagePickController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                }
                
                if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
                    [self presentViewController:_imagePickController animated:YES completion:nil];
                }
            }
            break;
        }
        case 3: // telefono
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                _imagePickController = [[UIImagePickerController alloc] init];
                _imagePickController.delegate = self;
                _imagePickController.SourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                _imagePickController.allowsEditing = YES;
                [self presentViewController:_imagePickController animated:YES completion:nil];
            }
            break;
        case 4:// editar
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                _imagePickController = [[UIImagePickerController alloc] init];
                _imagePickController.delegate = self;
                _imagePickController.SourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                _imagePickController.allowsEditing = YES;
                [self presentViewController:_imagePickController animated:YES completion:nil];
            }
            break;
        case 5:// restore the default picture
            [Utility deleteFileFromFileSystemWithName:[NSString stringWithFormat:@"user_%@.png", [FeedUserDefaults user]]
                                             inFolder:@"People"];
            [_userPicture setImageWithString:[FeedUserDefaults user] color:[UIColor whiteColor]];
            break;
        default:
            break;
    }
}


#pragma mark - Facebook Methods

- (void)connectFacebook {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        NSLog(@"FACEBOOK:existe una cuenta asociada al dispositivo");
        ACAccountType *FBaccountType= [accountStore accountTypeWithAccountTypeIdentifier: ACAccountTypeIdentifierFacebook];
        NSDictionary *options = @{@"ACFacebookAppIdKey" : FacebookAppIdKey,
                                  @"ACFacebookPermissionsKey" : @[@"email"],
                                  @"ACFacebookAudienceKey" : ACFacebookAudienceEveryone}; // Needed only when write permissions are requested
        
        [accountStore requestAccessToAccountsWithType:FBaccountType options:options completion: ^(BOOL granted, NSError *error) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"FACEBOOK:inicio de sesión exitoso");
                    NSArray *accounts = [accountStore accountsWithAccountType:FBaccountType];
                    if ([accounts count] > 0) {
                        ACAccount *facebookAccount = [accounts lastObject];
                        NSURL *url = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"http://graph.facebook.com/%@/picture?type=large",[[facebookAccount valueForKey:@"properties"]valueForKey:@"uid"]]];
                        NSData *data = [NSData dataWithContentsOfURL:url];
                        UIImage *imageFacebook = [UIImage imageWithData:data];
                        _userPicture.image = imageFacebook;
                        [self saveUserPicture:imageFacebook];
                    }
                });
            } else {
                // Fail gracefully...
                NSLog(@"FACEBOOK:No se pudo realizar la conexión con el servidor de Facebook%@",error);
                [self showAlert:NSLocalizedString(@"SettingsFacebook", @"") description:NSLocalizedString(@"Connection_Error", @"")];
            }
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            FBSession *session = [[FBSession alloc] initWithPermissions:@[@"publish_actions", @"email"]];
            // Set the active session
            [FBSession setActiveSession:session];
            // Open the session
            [session openWithBehavior:FBSessionLoginBehaviorForcingWebView completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                if(error == nil) {
                    NSLog(@"FACEBOOK:inicio de sesión exitoso");
                    if (session.isOpen) {
                        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                            if (!error) {
                                NSURL *url = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"http://graph.facebook.com/%@/picture?type=large",[user objectForKey:@"id"]]];
                                NSData *data = [NSData dataWithContentsOfURL:url];
                                UIImage *imageFacebook = [UIImage imageWithData:data];
                                _userPicture.image = imageFacebook;
                                [self saveUserPicture:imageFacebook];
                            } else {
                                // Fail gracefully...
                                [self showAlert:NSLocalizedString(@"SettingsFacebook", @"") description:NSLocalizedString(@"Connection_Error", @"")];
                                NSLog(@"FACEBOOK: Error en la conexión con el servidor %@", error);
                            }
                        }];
                    }
                } else {
                    NSLog(@"FACEBOOK:inicio de sesión no exitoso %@", error);
                    [self showAlert:NSLocalizedString(@"SettingsFacebook", @"") description:[NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Connection_Error", @""),error]];
                }
            }];
        });
    }
}


#pragma mark - Twitter Methods

- (void)connectTwitter{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        ACAccountType *twitterAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [accountStore requestAccessToAccountsWithType:twitterAccountType options:NULL completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    //  Step 2:  Create a request
                    NSArray *twitterAccounts = [accountStore accountsWithAccountType:twitterAccountType];
                    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com" @"/1.1/users/show.json"];
                    NSDictionary *params = @{@"screen_name" : [twitterAccounts valueForKey:@"username"],
                                             @"include_rts" : @"0",
                                             @"trim_user" : @"1",
                                             @"count" : @"1"};
                    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:params];
                    //  Attach an account to the request
                    [request setAccount:[twitterAccounts lastObject]];
                    //  Step 3:  Execute the request
                    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (responseData) {
                                if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                                    NSError *jsonError;
                                    NSDictionary *timelineData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
                                    if (timelineData) {
                                        NSLog(@"TWITTER:inicio de sesión exitoso");
                                        // Gets user's data from Twitter
                                        NSString *stringUrl = [NSString stringWithString:[timelineData objectForKey: @"profile_image_url"]];
                                        stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
                                        NSURL *url = [NSURL URLWithString:stringUrl];
                                        NSData *data = [NSData dataWithContentsOfURL:url];
                                        UIImage *imageTwitter = [UIImage imageWithData:data];
                                        _userPicture.image = imageTwitter;
                                        [self saveUserPicture:imageTwitter];
                                    } else {
                                        // Our JSON deserialization went awry
                                        NSLog(@"TWITTER:JSON Error- %@", [jsonError localizedDescription]);
                                        [self showAlert:NSLocalizedString(@"SettingsTwitter", @"") description:[NSString stringWithFormat:@"%@ -%@",NSLocalizedString(@"Connection_Error", @""), [jsonError localizedDescription]]];
                                    }
                                } else {
                                    // The server did not respond ... were we rate-limited?
                                    NSLog(@"TWITTER:No se pudo realizar la conexión, el estatus de la conexión es %ld", (long)urlResponse.statusCode);
                                    [self showAlert:NSLocalizedString(@"SettingsTwitter", @"") description:[NSString stringWithFormat:@"%@ %ld",NSLocalizedString(@"Connection_Error", @""), (long)urlResponse.statusCode]];
                                }
                            }
                        });
                    }];
                } else {
                    // Access was not granted, or an error occurred
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TWITTER:No se pudo realizar la conexión %@",[error localizedDescription]);
                        [self showAlert:NSLocalizedString(@"SettingsTwitter", @"") description:[NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Connection_Error", @""),[error localizedDescription]]];
                    });
                }
            });
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:TwitterAppIdKey andSecret:TwitterAppIdKeySecret];
            [[FHSTwitterEngine sharedEngine]loadAccessToken];
            UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
                if (success) {
                    NSLog(@"TWITTWER:incio de sesión exitoso");
                    // Gets user's data from Twitter
                    UIImage *imageTwitter = [[FHSTwitterEngine sharedEngine]getProfileImageForUsername:FHSTwitterEngine.sharedEngine.authenticatedUsername andSize:FHSTwitterEngineImageSizeOriginal];
                    _userPicture.image = imageTwitter;
                    [self saveUserPicture:imageTwitter];
                } else {
                    [self showAlert:NSLocalizedString(@"SettingsTwitter", @"") description:NSLocalizedString(@"Connection_Error", @"")];
                    NSLog(@"TWITTER:No se pudo realizar la conexión");
                }
            }];
            [self presentViewController:loginController animated:YES completion:nil];
        });
    }
}


#pragma mark - UIImagePicker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage * pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    _userPicture.image = pickedImage;
    [self saveUserPicture:pickedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIAlertView Methods

- (void)showAlert:(NSString *)title description:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:self
                      cancelButtonTitle:NSLocalizedString(@"OkButton", @"")
                      otherButtonTitles:nil] show];
}

- (void)saveUserPicture:(UIImage *)picture {
    // Save user data to the system
    [Utility saveImageToFileSystem:picture
                      withFileName:[NSString stringWithFormat:@"user_%@.png", [FeedUserDefaults user]]
                          inFolder:@"People"];
    //UIImageWriteToSavedPhotosAlbum(picture, nil, nil, nil);
}


#pragma mark - UIInterfaceOrientation Methods

- (BOOL)shouldAutorotate {
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
