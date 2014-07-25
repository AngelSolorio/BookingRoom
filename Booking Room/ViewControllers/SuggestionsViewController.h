//
//  SugerenciasViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 23/07/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface SuggestionsViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *suggestionsLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;

@end
