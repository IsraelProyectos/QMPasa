//
//  AuxiliarLeftMenuView.h
//  QMPasa
//
//  Created by Carles Frias Ferrer on 01/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuxiliarLeftMenuViewDelegate <NSObject>

- (void)auxiliarLeftMenuView:(id)auxiliarLeftMenuView didPressOpenDrawerButton:(UIButton*)btnOpenDrawer;
- (void)auxiliarLeftMenuView:(id)auxiliarLeftMenuView didPressDoneButton:(UIButton*)btnDone;

@end

@interface AuxiliarLeftMenuView : UIView

@property (weak, nonatomic) id <AuxiliarLeftMenuViewDelegate> delegate;

@end
