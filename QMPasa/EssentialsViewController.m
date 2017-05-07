//
//  EssentialsViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 30/06/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "EssentialsViewController.h"
#import "GenderViewController.h"
#import "RegionSelectorViewController.h"
#import "AgeViewController.h"
#import "RegionSelectorViewController.h"
#import "Constants.h"
#import "PostEssentialsViewController.h"

@interface EssentialsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnDone;

@property (strong, nonatomic) NSMutableArray *availableControllers;

@end

@implementation EssentialsViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.availableControllers = [[NSMutableArray alloc] initWithArray:@[@(EssentialControllerTypeGender),
                                                                        @(EssentialControllerTypeAge), @(EssentialControllerTypeHenry)]];
    self.selectedRegions = [[NSMutableArray alloc] init];
    [self btnDonePressed:nil];
}

#pragma mark - IBActions

- (IBAction)btnDonePressed:(UIButton*)btnDone {
    if (self.availableControllers.count == 0) {
        if (self.selectedRegions.count == 0) {
            return;
        }
        
        [self finishEssentialsViewController];
        return;
    }
    
    NSUInteger randomEssentialController;
    if (self.availableControllers.count > 1) {
        while (![self.availableControllers containsObject:@(randomEssentialController)]) {
            randomEssentialController = arc4random() % self.availableControllers.count;
        }
    }
    else {
        randomEssentialController = [[self.availableControllers firstObject] integerValue];
    }
    
    [self loadChildViewController:randomEssentialController];
}

#pragma mark - Private methods

- (void)loadChildViewController:(EssentialControllerType)essentialControllerType {
    UIViewController *newChildController;
    switch (essentialControllerType) {
        case EssentialControllerTypeGender:
            newChildController = [[GenderViewController alloc] init];
            [self.btnDone setHidden:YES];
            break;
            
        case EssentialControllerTypeAge:
            newChildController = [[AgeViewController alloc] init];
            [self.btnDone setHidden:NO];
            break;
            
        case EssentialControllerTypeHenry:
            newChildController = [[RegionSelectorViewController alloc] init];
            [self.btnDone setHidden:NO];
            break;
            
        default:
            break;
    }
    
    [self.availableControllers removeObject:@(essentialControllerType)];
    
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
    PostEssentialsViewController *temperatureController = [[PostEssentialsViewController alloc] initWithSelectedRegions:[NSArray arrayWithArray:self.selectedRegions]];
    [self.mm_drawerController setCenterViewController:temperatureController];
    [temperatureController.view addSubview:self.view];
    
    [UIView animateWithDuration:0.75 delay:0.15 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.view.alpha = 0;
    }
    completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

@end
