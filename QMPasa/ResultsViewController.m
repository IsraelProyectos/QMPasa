//
//  ResultsViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 27/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "ResultsViewController.h"
#import "HaztePruebasViewController.h"
#import "ResultadoInmediatoViewController.h"
#import "ResultadoMedicoViewController.h"
#import "ResultadoSeguimientoViewController.h"
#import "ResultadoUrgenteViewController.h"

@interface ResultsViewController ()

@property (strong, nonatomic) NSArray *availableControllers;
@property (assign, nonatomic) NSUInteger currentController;

@end

@implementation ResultsViewController

#pragma mark - UIViewController lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self btnDonePressed:nil];
}

#pragma mark - IBActions

- (IBAction)btnDonePressed:(UIButton*)btnDone {
    if (self.currentController == 4) {
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
            newChildController = [[HaztePruebasViewController alloc] init];
            break;
            
        case 1:
            newChildController = [[ResultadoInmediatoViewController alloc] init];
            break;
            
        case 2:
            newChildController = [[ResultadoMedicoViewController alloc] init];
            break;
            
        case 3:
            newChildController = [[ResultadoSeguimientoViewController alloc] init];
            break;
            
        case 4:
            newChildController = [[ResultadoUrgenteViewController alloc] init];
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
//    TemperatureViewController *temperatureController = [[TemperatureViewController alloc] initWithSelectedRegions:[NSArray arrayWithArray:self.selectedRegions]];
//    [self.mm_drawerController setCenterViewController:temperatureController];
//    [temperatureController.view addSubview:self.view];
//    
//    [UIView animateWithDuration:0.75 delay:0.15 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//        self.view.alpha = 0;
//    }
//                     completion:^(BOOL finished) {
//                         [self.view removeFromSuperview];
//                     }];
}

@end
