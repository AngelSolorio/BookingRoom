//
//  ImageEditorViewController.m
//  Booking Room
//
//  Created by Sandra Guzman on 13/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "ImageEditorViewController.h"

@interface ImageEditorViewController ()

@end

@implementation ImageEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _saveButton = nil;
    self.cropRect = CGRectMake(0,0,320,320);
    self.minimumScale = 0.2;
    self.maximumScale = 10;
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0f, 58.0f, 320.0f, 320.0f)];
    [path2 setUsesEvenOddFillRule:YES];
    [circleLayer setPath:[path2 CGPath]];
    [circleLayer setFillColor:[[UIColor clearColor] CGColor]];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 320, self.view.frame.size.height+48) cornerRadius:0];
    [path appendPath:path2];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.opacity = 0.3;
    [self.view.layer addSublayer:fillLayer];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    _saveButton = nil;
    
}


#pragma mark Hooks

- (void)startTransformHook {
    _saveButton.tintColor = [UIColor colorWithRed:0 green:49/255.0f blue:98/255.0f alpha:1];
}

- (void)endTransformHook {
    _saveButton.tintColor = [UIColor colorWithRed:0 green:128/255.0f blue:1 alpha:1];
}

@end
