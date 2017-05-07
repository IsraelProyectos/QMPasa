//
//  RootViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 30/06/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <AuxiliarLeftMenuViewDelegate>

@end

@implementation RootViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftMenuView = [[AuxiliarLeftMenuView alloc] init];
    [self.leftMenuView setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.leftMenuView];
    
}

#pragma mark - AuxiliarLeftMenuView delegates

- (void)auxiliarLeftMenuView:(id)auxiliarLeftMenuView didPressOpenDrawerButton:(UIButton *)btnOpenDrawer {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)auxiliarLeftMenuView:(id)auxiliarLeftMenuView didPressDoneButton:(UIButton *)btnDone {
    if ([self.auxiliarMenuDelegate respondsToSelector:@selector(rootController:didPressDoneButton:)]) {
        [self.auxiliarMenuDelegate rootController:self didPressDoneButton:btnDone];
    }
}

@end
