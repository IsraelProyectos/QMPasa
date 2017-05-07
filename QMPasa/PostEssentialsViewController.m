//
//  PostEssentialsViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 28/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "PostEssentialsViewController.h"
#import "TemperatureViewController.h"
#import "RegionDetailViewController.h"
#import "HospitalizationViewController.h"
#import "KnownDiseasesViewController.h"
#import "ButtonDone.h"

@interface PostEssentialsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnDone;

@property (strong, nonatomic) NSArray *selectedRegions;
@property (strong, nonatomic) NSArray *availableControllers;
@property (assign, nonatomic) NSUInteger currentController;

@end

@implementation PostEssentialsViewController

#pragma mark - UIViewController lifecycle

- (instancetype)initWithSelectedRegions:(NSArray*)selectedRegions {
    self = [super init];
    
    if (self) {
        self.selectedRegions = selectedRegions;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self btnDonePressed:nil];
//    ButtonDown *myButton = [[ButtonDown alloc] init];
//    [myButton buttonWithMyCompanyStyles:self.btnDone];
   
}

#pragma mark - IBActions

- (IBAction)btnDonePressed:(UIButton*)btnDone {
    if (self.currentController == 3) {
        [self finishEssentialsViewController];
        return;
    }
    
    [self loadChildViewController:self.currentController];
    self.currentController++;
}

#pragma mark - Private methods

- (void)loadChildViewController:(NSUInteger)currentController {
    UIViewController *newChildController;
    switch (currentController) {
        case 0:
            newChildController = [[TemperatureViewController alloc] init];
            break;
            
        case 1:
            newChildController = [[HospitalizationViewController alloc] init];
            break;

        case 2:
            newChildController = [[KnownDiseasesViewController alloc] init];
            break;

        default:
            break;
    }
    
    UIViewController *currentChildController = [self.childViewControllers firstObject];
    [self addChildViewController:newChildController];
    [newChildController.view setFrame:self.view.frame];
    
    if (currentChildController) {
        [currentChildController willMoveToParentViewController:nil];
        
        [UIView transitionFromView:currentChildController.view toView:newChildController.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            [currentChildController.view removeFromSuperview];
            [currentChildController removeFromParentViewController];
        }];
    }
    else {
        [self.view addSubview:newChildController.view];
    }
    
    [newChildController didMoveToParentViewController:self];
    [self.view sendSubviewToBack:newChildController.view];
}

- (void)finishEssentialsViewController {
    RegionDetailViewController *regionDetailViewController = [[RegionDetailViewController alloc] initWithRegions:self.selectedRegions];
    [self.mm_drawerController setCenterViewController:regionDetailViewController];
    [regionDetailViewController.view addSubview:self.view];
    
    [UIView animateWithDuration:0.75 delay:0.15 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.view.alpha = 0;
    }
    completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

@end
