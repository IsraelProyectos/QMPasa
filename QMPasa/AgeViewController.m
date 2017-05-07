//
//  AgeViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 05/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "AgeViewController.h"

@interface AgeViewController ()

@property (weak, nonatomic) IBOutlet UIView *vAuxiliar;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;

@property (strong, nonatomic) IBOutlet UISlider *slider;

@end

@implementation AgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backgroundTrack = [UIImage imageNamed:@"ageWhite"];
    UIImage *foregroundTrack = [[UIImage imageNamed:@"ageWhite"] resizableImageWithCapInsets:UIEdgeInsetsZero];
    UIImage *thumb = [UIImage imageNamed:@"sliderThumb"];
    
    [self.slider setMinimumValue:18.0f];
    [self.slider setMaximumValue:100.0f];
    [self.slider setMinimumTrackImage:foregroundTrack forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:backgroundTrack forState:UIControlStateNormal];
    [self.slider setThumbImage:thumb forState:UIControlStateNormal];
    
    [self.slider setValue:100 - 24.0f];
    [self.slider addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.vAuxiliar addSubview:self.slider];
    [self.vAuxiliar setTransform:CGAffineTransformMakeRotation((M_PI * 270) / 180)];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect sliderFrame = CGRectMake(self.slider.frame.origin.x, self.slider.frame.origin.y, 454, self.slider.frame.size.height);
    [self.slider setFrame:sliderFrame];
}

- (void)didChangeValue:(UISlider*)slider {
    CGFloat tempDegrees = 100 - slider.value;
    NSString *stringTempDegrees = [NSString stringWithFormat:@"%.f", tempDegrees];
    
    [self.lblAge setText:stringTempDegrees];
}

@end
