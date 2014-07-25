//
//  VTPinPadViewController.h
//  Booking Room
//
//  Created by Angel Solorio on 2/27/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.


#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Utility.h"
#import "UIImage+ImageEffects.h"


@protocol PinPadPasswordProtocol <NSObject>
@required
- (NSInteger)pinLenght;
- (BOOL)checkPin:(NSString *)pin;
@optional
- (void)newPinSet:(NSString *)newPin inViewController:(UIViewController *)pvc;
- (void)pinAuthenticatedInViewController:(UIViewController *)pvc;
@end


@interface PPPinPadViewController : UIViewController {
    __weak IBOutlet UIView *_pinCirclesView;
    __weak IBOutlet UIView *_errorView;
    __weak IBOutlet UILabel *_errorMessageLabel;
    NSMutableString *_inputPin;
    NSMutableArray *_circleViewList;
}

@property (nonatomic,assign) id<PinPadPasswordProtocol> delegate;
@property (nonatomic, assign) NSInteger mode;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *background;

- (id)initWithMode:(NSInteger)mode;

@end
