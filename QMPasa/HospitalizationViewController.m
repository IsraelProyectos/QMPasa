//
//  HospitalizationViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 28/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "HospitalizationViewController.h"

@interface HospitalizationViewController ()

@property (weak, nonatomic) IBOutlet UIView *vAuxiliar;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation HospitalizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backgroundTrack = [UIImage imageNamed:@"hospitalizationBar"];
    UIImage *foregroundTrack = [[UIImage imageNamed:@"hospitalizationBar"] resizableImageWithCapInsets:UIEdgeInsetsZero];
    UIImage *thumb = [UIImage imageNamed:@"hospitalizationThumb"];
    
    [self.slider setMinimumValue:0.0f];
    [self.slider setMaximumValue:10.0f];
    [self.slider setMinimumTrackImage:foregroundTrack forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:backgroundTrack forState:UIControlStateNormal];
    [self.slider setThumbImage:thumb forState:UIControlStateNormal];
    
    [self.slider setValue:0.0f];
    
    [self.vAuxiliar addSubview:self.slider];
    [self.vAuxiliar setTransform:CGAffineTransformMakeRotation((M_PI * 270) / 180)];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect sliderFrame = CGRectMake(self.slider.frame.origin.x, self.slider.frame.origin.y, 281, self.slider.frame.size.height);
    [self.slider setFrame:sliderFrame];
}

@end
