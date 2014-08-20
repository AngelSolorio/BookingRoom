//
//  SugerenciasViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "SuggestionsViewController.h"

@interface SuggestionsViewController ()

@end

@implementation SuggestionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Creates the activity indicator
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.center = CGPointMake(self.commentsTextView.frame.size.width / 2, self.commentsTextView.frame.size.height / 2);
    self.indicator.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.indicator.hidesWhenStopped = YES;
    [self.commentsTextView addSubview:self.indicator];
    
    _sendButton.enabled = FALSE;
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self willRotateToInterfaceOrientation:interfaceOrientation duration:2];
    
    // Shows the Navigation Bar
    [self.navigationController setNavigationBarHidden:NO];
    
    // Applies the blur effect to the background image
    _backgroundImage = [UIImage imageNamed:@"BackgroundViewControllers"];
    _background.image = [_backgroundImage applyExtraLightEffect];
    _background.layer.masksToBounds = YES;
    _background.layer.cornerRadius = 10.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_commentsTextView becomeFirstResponder];
}


#pragma mark - UITextViewDelegate Methods

- (void)textViewDidChange:(UITextView *)textView {
    if (_commentsTextView.text.length > 0) {
        _sendButton.enabled = YES;
    } else {
        _sendButton.enabled = FALSE;
    }
}


#pragma mark - UIInterfaceOrientation Methods

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) { // LANSCAPE
        [self.navigationController setNavigationBarHidden:YES];
        if ([Utility getScreenSize].height < 568.0f) { // iPhone 4, 4S
            _suggestionsLabel.frame = CGRectMake(16, 14, 455, _suggestionsLabel.frame.size.height);
            _commentsTextView.frame = CGRectMake(16, 55, 450, 320 - 220);
            _background.frame = CGRectMake(16, 55, 450, 320 - 220);
        } else {
            _suggestionsLabel.frame = CGRectMake(16, 14, 535, _suggestionsLabel.frame.size.height);
            _commentsTextView.frame = CGRectMake(16, 55, 537, 320 - 220);
            _background.frame = CGRectMake(16, 55, 537, 320 - 220);
        }
    } else { // PORTRAIT
        [self.navigationController setNavigationBarHidden:NO];
        if ([Utility getScreenSize].height < 568.0f) { // iPhone 4, 4S
            _suggestionsLabel.frame = CGRectMake(16, 71, 289,  _suggestionsLabel.frame.size.height);
            _commentsTextView.frame = CGRectMake(16, 113, 290, 480 - 330);
            _background.frame = CGRectMake(16, 113, 290, 480 - 330);
        } else {
            _suggestionsLabel.frame = CGRectMake(16, 71, 289, _suggestionsLabel.frame.size.height);
            _commentsTextView.frame = CGRectMake(16, 113, 290, 568 - 330);
            _background.frame = CGRectMake(16, 113, 290, 568 - 330);
        }
    }
}

- (IBAction)sendSuggestions:(id)sender {
    _sendButton.enabled = NO;
    [self.indicator startAnimating];
    
    // ---- Requests the login to the Web Service using the AFNetworking Framework ----
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [[WebService sharedClient] sendComment:_commentsTextView.text
                                completion:^(NSDictionary *results, NSError *error){
                                    [self getSuggestionsResults:results error:error];
                                }];
}


#pragma mark - Web Service Response

- (void)getSuggestionsResults:(NSDictionary *)results error:(NSError *)error {
    // Stops the activity indicator
    [self.indicator stopAnimating];
    
    if ([[results objectForKey:@"success"] boolValue]) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Suggestion_TitleLabel", nil)
                                    message:NSLocalizedString(@"Suggestion_Message", nil)
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"OkButton", nil)
                          otherButtonTitles:nil]
         show];
        NSLog(@"EVENT: %@", NSLocalizedString(@"Login_Success", nil));
        _commentsTextView.text = @"";
        
    } else if (error.code == 401) { // Invalid User Token
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Suggestion_TitleLabel", nil)
                                    message:NSLocalizedString(@"TokenInvalid", nil)
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"OkButton", nil)
                          otherButtonTitles: nil] show];
        NSLog(@"EVENT: %@", NSLocalizedString(@"TokenInvalid", nil));
    } else {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Suggestion_TitleLabel", nil)
                                    message:NSLocalizedString(@"Connection_Error", nil)
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"OkButton", nil)
                          otherButtonTitles: nil]
         show];
        NSLog(@"EVENT: %@", NSLocalizedString(@"Connection_Error", nil));
    }
    
    _sendButton.enabled = YES;
}

@end
