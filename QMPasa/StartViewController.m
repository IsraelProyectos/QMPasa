//
//  StartViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 30/06/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "StartViewController.h"
#import "DrawerController.h"
#import "LeftMenuViewController.h"
#import "EssentialsViewController.h"
#import "NetworkController.h"

@interface StartViewController ()

@end

@implementation StartViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NetworkController updatePointsWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"Error while upading points");
        }
    }];
}

#pragma mark - IBAction

- (IBAction)btnStartPressed:(id)sender {
    EssentialsViewController *centerViewController = [[EssentialsViewController alloc] init];
    LeftMenuViewController *leftMenuViewController = [[LeftMenuViewController alloc] init];
    DrawerController *drawerController = [[DrawerController alloc] initWithCenterViewController:centerViewController leftDrawerViewController:leftMenuViewController];
    
    [UIView transitionFromView:self.view toView:drawerController.view duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:drawerController];
    }];
}

@end
