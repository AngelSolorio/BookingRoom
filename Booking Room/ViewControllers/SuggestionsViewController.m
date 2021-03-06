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
    
    _sendButton.enabled = FALSE;
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self willRotateToInterfaceOrientation:interfaceOrientation duration:2];
    
    // Applies the blur effect to the background image
    _backgroundImage = [UIImage imageNamed:@"BackgroundGeneral"];
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"] && ![textView.text isEqualToString:@""]) {
        [self sendSuggestions:nil];
    }
    
    return YES;
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
    // ---- Requests the suggestions to the Web Service using the AFNetworking Framework ----
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [[WebService sharedClient] sendComment:_commentsTextView.text
                                completion:^(NSDictionary *results, NSError *error){
                                    [self getSuggestionsResults:results error:error];
                                }];
}


#pragma mark - Web Service Response

- (void)getSuggestionsResults:(NSDictionary *)results error:(NSError *)error {
    _commentsTextView.text = @"";
    _sendButton.enabled = NO;
    // Stops the activity indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if ([[results objectForKey:@"success"] boolValue]) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Suggestion_TitleLabel", nil)
                                    message:NSLocalizedString(@"Suggestion_Message", nil)
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"OkButton", nil)
                          otherButtonTitles:nil]
         show];
        NSLog(@"EVENT: %@", NSLocalizedString(@"Login_Success", nil));
        
    } else if (error.code == 401) { // Invalid User Token
        UIAlertView *alertToken = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Suggestion_TitleLabel", nil)
                                    message:NSLocalizedString(@"TokenInvalid", nil)
                                   delegate:self
                          cancelButtonTitle:NSLocalizedString(@"OkButton", nil)
                          otherButtonTitles: nil];
        alertToken.tag = 401;
        [alertToken show];
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
    
    [_sendButton setEnabled:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 401) {
        [self.navigationController.parentViewController.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
