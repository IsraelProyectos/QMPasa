//
//  DrawerController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 30/06/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "DrawerController.h"

@interface DrawerController ()

@end

@implementation DrawerController

#pragma mark - UIViewController lifecycle

- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController {
    self = [super initWithCenterViewController:centerViewController leftDrawerViewController:leftDrawerViewController];
    
    if (self) {
        CGFloat maxDrawerWidth = (self.view.frame.size.width * 2) / 3;
        [self setMaximumLeftDrawerWidth:maxDrawerWidth];
        [self setMaximumRightDrawerWidth:maxDrawerWidth];
        
        [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        [self setShowsShadow:NO];
    }
    
    return self;
}

@end
