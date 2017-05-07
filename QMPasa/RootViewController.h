//
//  RootViewController.h
//  QMPasa
//
//  Created by Carles Frias Ferrer on 30/06/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawerController.h"
#import "AuxiliarLeftMenuView.h"
#import <UIViewController+MMDrawerController.h>

@protocol RootControllerDelegate <NSObject>

- (void)rootController:(id)rootController didPressDoneButton:(UIButton*)doneButton;

@end

@interface RootViewController : UIViewController

@property (strong, nonatomic) AuxiliarLeftMenuView *leftMenuView;

@property (weak, nonatomic) id <RootControllerDelegate> auxiliarMenuDelegate;

@end
