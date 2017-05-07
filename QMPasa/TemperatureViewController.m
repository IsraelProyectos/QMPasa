//
//  TemperatureViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 01/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "TemperatureViewController.h"
#import "RegionDetailViewController.h"

@interface TemperatureViewController ()

@property (weak, nonatomic) IBOutlet UIView *vAuxiliar;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *lblTempDegrees;
@property (weak, nonatomic) IBOutlet UILabel *lblTempFahrenheit;

@end

@implementation TemperatureViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backgroundTrack = [UIImage imageNamed:@"thermometerWhite"];
    UIImage *foregroundTrack = [[UIImage imageNamed:@"thermometerRed"] resizableImageWithCapInsets:UIEdgeInsetsZero];
    UIImage *thumb = [UIImage imageNamed:@"sliderThumb"];
    
    [self.slider setMinimumValue:30.0f];
    [self.slider setMaximumValue:42.0f];
    [self.slider setMinimumTrackImage:foregroundTrack forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:backgroundTrack forState:UIControlStateNormal];
    [self.slider setThumbImage:thumb forState:UIControlStateNormal];
    
    [self.slider setValue:36.0f];
    [self.slider addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.vAuxiliar addSubview:self.slider];
    [self.vAuxiliar setTransform:CGAffineTransformMakeRotation((M_PI * 270) / 180)];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect sliderFrame = CGRectMake(self.slider.frame.origin.x, self.slider.frame.origin.y, 480, self.slider.frame.size.height);
    [self.slider setFrame:sliderFrame];
}

#pragma mark - IBActions

- (void)didChangeValue:(UISlider*)slider {
    CGFloat tempDegrees = slider.value;
    CGFloat tempFahrenheit = (tempDegrees * 1.8) + 32;
    
    NSString *stringTempDegrees = [NSString stringWithFormat:@"%.1f ºC", tempDegrees];
    NSString *stringTempFahrenheit = [NSString stringWithFormat:@"%.1f F", tempFahrenheit];
    
    [self.lblTempDegrees setText:stringTempDegrees];
    [self.lblTempFahrenheit setText:stringTempFahrenheit];
}

@end
