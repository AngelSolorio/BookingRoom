//
//  VTPinPadViewController.m
//  Booking Room
//
//  Created by Angel Solorio on 2/27/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.

#import "PPPinPadViewController.h"
#import "PPPinCircleView.h"
#import "TypeDefs.h"


@interface PPPinPadViewController () {
    NSInteger _shakes;
    NSInteger _direction;
    NSString *_pinToConfirm;
}

@end

static  CGFloat kVTPinPadViewControllerCircleRadius = 6.0f;

@implementation PPPinPadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithMode:(NSInteger)mode {
    self = [super init];
    if (self) {
        _mode = mode;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCircles];
    _pinToConfirm = [[NSString alloc] init];

    // Set the title's controls
    [_leftButton setTitle:NSLocalizedString(@"Pin_Cancel", nil) forState:UIControlStateNormal];
    [_rightButton setTitle:NSLocalizedString(@"Pin_Reset", nil) forState:UIControlStateNormal];

    if (_mode == kNeverSet) {
        _titleLabel.text = NSLocalizedString(@"Pin_CreatePIN", nil);
    } else {
        _titleLabel.text = NSLocalizedString(@"Pin_EnterPIN", nil);
        _mode = kAlreadySet;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIInterfaceOrientation Methods

- (BOOL)shouldAutorotate {
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark Status Bar

- (void)changeStatusBarHidden:(BOOL)hidden {
    _errorView.hidden = hidden;
    [self setNeedsStatusBarAppearanceUpdate];
}


- (BOOL)prefersStatusBarHidden {
    return !_errorView.hidden;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark Actions

- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)resetClick:(id)sender {
    [self addCircles];
    _inputPin = [NSMutableString string];
}


- (IBAction)numberButtonClick:(id)sender {
    if(!_inputPin) {
        _inputPin = [NSMutableString new];
    }
    
    if(!_errorView.hidden) {
        [self changeStatusBarHidden:YES];
    }
    
    [_inputPin appendString:[((UIButton*)sender) titleForState:UIControlStateNormal]];
    [self fillingCircle:_inputPin.length - 1];
    
    if ([self pinLenght] == _inputPin.length) {
        double delayInSeconds = 0.25f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            if (_mode == kNeverSet) { // Setting a new PIN
                if ([self isValidPin:_inputPin]) {
                    _pinToConfirm = _inputPin;
                    _direction = 1;
                    _shakes = 0;
                    _titleLabel.text = NSLocalizedString(@"Pin_ConfirmPIN", nil);
                    _mode = kToConfirm;
                    [self resetClick:self];
                } else {
                    _errorMessageLabel.text = NSLocalizedString(@"Pin_NotValid", nil);
                    _direction = 1;
                    _shakes = 0;
                    [self shakeCircles:_pinCirclesView];
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                    [self changeStatusBarHidden:NO];
                }
            } else if (_mode == kToConfirm) { // Confirming a new PIN
                if ([_pinToConfirm isEqualToString:_inputPin]) { // Successful
                    NSLog(@"EVENT: %@", NSLocalizedString(@"Pin_CreatePIN", nil));
                    if ([_delegate respondsToSelector:@selector(newPinSet:inViewController:)]) {
                        [_delegate newPinSet:_inputPin inViewController:self];
                    }
                } else { // Error
                    _errorMessageLabel.text = NSLocalizedString(@"Pin_NotMatchPin", nil);
                    _direction = 1;
                    _shakes = 0;
                    [self shakeCircles:_pinCirclesView];
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                    [self changeStatusBarHidden:NO];
                }
            } else if ([self checkPin:_inputPin]) { // Correct Pin Authentication
                if ([_delegate respondsToSelector:@selector(pinAuthenticatedInViewController:)]) {
                    [_delegate pinAuthenticatedInViewController:self];
                }
            } else { // Incorrect Pin Authentication
                _errorMessageLabel.text = NSLocalizedString(@"Pin_IncorrectPIN", nil);
                _direction = 1;
                _shakes = 0;
                [self shakeCircles:_pinCirclesView];
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                [self changeStatusBarHidden:NO];
            }
        });
    }
}


- (BOOL)isValidPin:(NSString*)pin {
    NSArray *invalidCombinations = [[NSArray alloc] initWithObjects:@"0000", @"1111", @"2222", @"3333", @"4444", @"5555", @"6666", @"7777", @"8888", @"9999",
                                    @"0123", @"1234", @"2345", @"3456", @"4567", @"5678", @"6789", @"9876", @"8765", @"7654", @"6543", @"5432", @"4321", @"3210", nil];
    for (NSString *combination in invalidCombinations) {
        if ([combination isEqualToString:pin]) {
            return NO;
        }
    }
    return YES;
}


#pragma mark Delegate & methods

- (void)setDelegate:(id<PinPadPasswordProtocol>)delegate {
    if(_delegate != delegate) {
        _delegate = delegate;
        [self addCircles];
    }
}


- (BOOL)checkPin:(NSString *)pinString {
    if([self.delegate respondsToSelector:@selector(checkPin:)]) {
        return [self.delegate checkPin:pinString];
    }
    return YES;
}


- (NSInteger)pinLenght {
    if([self.delegate respondsToSelector:@selector(pinLenght)]) {
        return [self.delegate pinLenght];
    }
    return 4;
}


#pragma mark Circles

- (void)addCircles {
    if([self isViewLoaded] && self.delegate) {
        [[_pinCirclesView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_circleViewList removeAllObjects];
        _circleViewList = [NSMutableArray array];
        
        CGFloat neededWidth =  [self pinLenght] * kVTPinPadViewControllerCircleRadius;
        CGFloat shiftBetweenCircle = (_pinCirclesView.frame.size.width - neededWidth )/([self pinLenght] +2);
        CGFloat indent= 1.5* shiftBetweenCircle;
        if(shiftBetweenCircle > kVTPinPadViewControllerCircleRadius * 5.0f) {
            shiftBetweenCircle = kVTPinPadViewControllerCircleRadius * 5.0f;
            indent = (_pinCirclesView.frame.size.width - neededWidth  - shiftBetweenCircle *([self pinLenght] > 1 ? [self pinLenght]-1 : 0))/2;
        }
        for(int i=0; i < [self pinLenght]; i++) {
            PPPinCircleView * circleView = [PPPinCircleView circleView:kVTPinPadViewControllerCircleRadius];
            CGRect circleFrame = circleView.frame;
            circleFrame.origin.x = indent + i * kVTPinPadViewControllerCircleRadius + i*shiftBetweenCircle;
            circleFrame.origin.y = (CGRectGetHeight(_pinCirclesView.frame) - kVTPinPadViewControllerCircleRadius)/2.0f;
            circleView.frame = circleFrame;
            [_pinCirclesView addSubview:circleView];
            [_circleViewList addObject:circleView];
        }
    }
}


- (void)fillingCircle:(NSInteger)symbolIndex {
    if(symbolIndex >= _circleViewList.count)
        return;
    PPPinCircleView *circleView = [_circleViewList objectAtIndex:symbolIndex];
    circleView.backgroundColor = [UIColor whiteColor];
}


- (void)shakeCircles:(UIView *)theOneYouWannaShake {
    [UIView animateWithDuration:0.03 animations:^ {
         theOneYouWannaShake.transform = CGAffineTransformMakeTranslation(5*_direction, 0);
     } completion:^(BOOL finished) {
         if(_shakes >= 15) {
             theOneYouWannaShake.transform = CGAffineTransformIdentity;
             [self resetClick:nil];
             return;
         }
         _shakes++;
         _direction = _direction * -1;
         [self shakeCircles:theOneYouWannaShake];
     }];
}

@end
