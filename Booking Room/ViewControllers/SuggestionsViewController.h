//
//  SugerenciasViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "UIImage+ImageEffects.h"
#import "WebService.h"

@interface SuggestionsViewController : UIViewController <UITextViewDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *suggestionsLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *background;

- (IBAction)sendSuggestions:(id)sender;

@end
