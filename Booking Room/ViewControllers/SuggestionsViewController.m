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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self willRotateToInterfaceOrientation:interfaceOrientation duration:2];
}

- (void)didReceiveMemoryWarning
{
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

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) { // LANSCAPE
        [self.navigationController setNavigationBarHidden:YES];
        if ([Utility getScreenSize].height < 568.0f) { // iPhone 4, 4S
            _suggestionsLabel.frame = CGRectMake(16, 14, 455 - _sendButton.frame.size.width, _suggestionsLabel.frame.size.height);
            _sendButton.frame = CGRectMake(_suggestionsLabel.frame.size.width + 20, 17, _sendButton.frame.size.width, _sendButton.frame.size.height);
            _commentsTextView.frame = CGRectMake(16, 55, 450, 320 - 220);
        } else {
            _suggestionsLabel.frame = CGRectMake(16, 14, 535 - _sendButton.frame.size.width, _suggestionsLabel.frame.size.height);
            _sendButton.frame = CGRectMake(_suggestionsLabel.frame.size.width + 20, 17, _sendButton.frame.size.width, _sendButton.frame.size.height);
            _commentsTextView.frame = CGRectMake(16, 55, 537, 320 - 220);
        }
    } else { // PORTRAIT
        [self.navigationController setNavigationBarHidden:NO];
        if ([Utility getScreenSize].height < 568.0f) { // iPhone 4, 4S
            _suggestionsLabel.frame = CGRectMake(16, 71, 221,  _suggestionsLabel.frame.size.height);
            _sendButton.frame = CGRectMake(252, 75, 53, _sendButton.frame.size.height);
            _commentsTextView.frame = CGRectMake(16, 113, 290, 480 - 330);
        } else {
            _suggestionsLabel.frame = CGRectMake(16, 71, 221, _suggestionsLabel.frame.size.height);
            _sendButton.frame = CGRectMake(252, 75, 53, _sendButton.frame.size.height);
            _commentsTextView.frame = CGRectMake(16, 113, 290, 568 - 330);
        }
    }
}

@end
