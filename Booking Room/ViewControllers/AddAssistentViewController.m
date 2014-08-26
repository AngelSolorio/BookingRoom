//
//  AddAssistentViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 25/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "AddAssistentViewController.h"

@interface AddAssistentViewController ()

@end

@implementation AddAssistentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Applies the blur effect to the background image
    _viewPopOver.layer.cornerRadius = 6;
    _viewPopOver.layer.borderColor = [UIColor grayColor].CGColor;
    _viewPopOver.layer.borderWidth = 1;
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
    
    // Attach method to segment control
    [_segmentAssistants addTarget:self
                       action:@selector(didChangeSegmentControl:)
             forControlEvents:UIControlEventValueChanged];
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
        NSLog(@"Sellcom assistants");
    } else {
        NSLog(@"External assistants");
    }
}

@end
