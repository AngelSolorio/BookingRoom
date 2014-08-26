//
//  AddAssistentViewController.h
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import "Utility.h"
#import "UIImage+ImageEffects.h"
#import "ExternalAssistantViewController.h"
#import "InternalAssistantViewController.h"

@interface AddAssistentViewController : UIViewController

@property (nonatomic, strong) UIImage *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIView *viewPopOver;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentAssistants;

- (IBAction)closePopOver:(id)sender;

@end
