//
//  GenderViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 01/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "GenderViewController.h"
#import "EssentialsViewController.h"

@interface GenderViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnMale;
@property (weak, nonatomic) IBOutlet UIButton *btnFemale;

@property (strong, nonatomic) EssentialsViewController *parentController;

@end

@implementation GenderViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parentController = (EssentialsViewController*) self.parentViewController;
}

#pragma mark - IBActions

- (IBAction)btnMalePressed:(UIButton*)btnMale {
    [btnMale setBackgroundColor:[UIColor colorWithRed:251/255.f green:112/255.f blue:93/255.f alpha:1.f]];
    [self.btnFemale setBackgroundColor:[UIColor colorWithRed:206/255.f green:207/255.f blue:206/255.f alpha:1.f]];
    
    [self btnDonePressedWithDelay];
}

- (IBAction)btnFemalePressed:(UIButton*)btnFemale {
    [btnFemale setBackgroundColor:[UIColor colorWithRed:251/255.f green:112/255.f blue:93/255.f alpha:1.f]];
    [self.btnMale setBackgroundColor:[UIColor colorWithRed:206/255.f green:207/255.f blue:206/255.f alpha:1.f]];
    
    [self btnDonePressedWithDelay];
}

#pragma mark - Private methods

- (void)btnDonePressedWithDelay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.parentController btnDonePressed:nil];
    });
}

@end
