//
//  ActionSheetCalendarViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 27/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "ActionSheetCalendarViewController.h"

@interface ActionSheetCalendarViewController ()

@end

@implementation ActionSheetCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Applies the blur effect to the background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[_backgroundImage applyBlurWithRadius:2 tintColor:[UIColor colorWithRed:32.0/255.0f green:32.0/255.0f blue:32.0/255.0f alpha:0.5] saturationDeltaFactor:1 maskImage:_backgroundImage]];
    _backgroundImage = [UIImage imageNamed:@"BackgroundMenu"];
    _background.image = [_backgroundImage applyExtraLightEffect];
    _background.layer.masksToBounds = YES;
    _background.layer.cornerRadius = 5.0f;
    _background.layer.borderWidth = 0.3f;
    _background.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _backgroundButton.image = [_backgroundImage applyExtraLightEffect];
    _backgroundButton.layer.masksToBounds = YES;
    _backgroundButton.layer.cornerRadius = 5.0f;
    _backgroundButton.layer.borderWidth = 0.3f;
    _backgroundButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _titleCalendar.layer.cornerRadius = 5.0f;
    _titleCalendar.layer.borderWidth = 0.3f;
    _titleCalendar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _selectedButton.layer.cornerRadius = 5.0f;
    _selectedButton.layer.borderWidth = 0.3f;
    _selectedButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.view.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.width);
    
    // Dismiss view with touch outside picker
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(closePicker:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration: 0.2 animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.view.frame.size.height -  (_contentView.frame.size.width + 10), _contentView.frame.size.width, _contentView.frame.size.height);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIView animateWithDuration: 0.2 animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x,  self.view.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
    }];
}

- (void)setTitlePicker:(NSString *)title {
    _titleCalendar.text = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closePicker:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)selectedDatePicker:(id)sender {
    NSDate *date = [_datePicker date];
    [self.delegate setSelectedDatePicker:date];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
