//
//  QTKViewController.m
//  Glow
//
//  Created by Kevin Lee on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QTKViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>

@interface QTKViewController ()
@property CALayer *sublayer;
@property BOOL animating;
@end

@implementation QTKViewController
@synthesize sublayer;
@synthesize animating;
- (void)animate {
    self.animating = YES;
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    theAnimation.duration=1.0;
    theAnimation.repeatCount=HUGE_VALF;
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:10.0];
    theAnimation.toValue=[NSNumber numberWithFloat:5.0];
    [self.sublayer addAnimation:theAnimation forKey:@"animateOpacity"];
    
    CABasicAnimation *theColorAnimation;
    theColorAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theColorAnimation.duration=1.0;
    theColorAnimation.repeatCount=HUGE_VALF;
    theColorAnimation.autoreverses=YES;
    theColorAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theColorAnimation.toValue=[NSNumber numberWithFloat:.5];
    [self.sublayer addAnimation:theColorAnimation forKey:@"backgroundColor"];
}

- (void)animateToBlue {
    CABasicAnimation* selectionAnimation = [CABasicAnimation 
                                            animationWithKeyPath:@"backgroundColor"];
    selectionAnimation.toValue = (id)[UIColor colorWithRed:0.0 green:216.0/255 blue:1.0 alpha:1].CGColor;
    selectionAnimation.duration = .5;
    selectionAnimation.fillMode = kCAFillModeForwards;
    selectionAnimation.removedOnCompletion = NO;
    [self.sublayer addAnimation:selectionAnimation
                         forKey:@"toBlueAnimation"];

}

- (void)animateToGreen {
    CABasicAnimation* selectionAnimation = [CABasicAnimation 
                                            animationWithKeyPath:@"backgroundColor"];
    selectionAnimation.toValue = (id)[UIColor greenColor].CGColor;
    selectionAnimation.duration = .5;
    selectionAnimation.fillMode = kCAFillModeForwards;
    selectionAnimation.removedOnCompletion = NO;
    [self.sublayer addAnimation:selectionAnimation
                         forKey:@"toGreenAnimation"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [UIColor blackColor].CGColor;

    self.sublayer = [CALayer layer];
    self.sublayer.backgroundColor = [UIColor colorWithRed:0.0 green:216.0/255 blue:1.0 alpha:1].CGColor;
    self.sublayer.shadowOffset = CGSizeMake(0, 3);
    self.sublayer.shadowRadius = 10.0;
    self.sublayer.shadowColor = [UIColor whiteColor].CGColor;
    self.sublayer.shadowOpacity = 0.8;
    self.sublayer.opacity = 1.0;
    self.sublayer.frame = CGRectMake(100, 100, 100, 100);
    self.sublayer.cornerRadius = 50.0;
    [self.view.layer addSublayer:self.sublayer];

    
    [self animate];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.animating) {
        [self.sublayer removeAllAnimations];
        self.sublayer.backgroundColor = [UIColor greenColor].CGColor;
        self.animating = NO;
    } else {
        [self animateToBlue];
        [self animate];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
