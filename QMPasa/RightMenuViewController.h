//
//  RightMenuViewController.h
//  QMPasa
//
//  Created by Carles Frias Ferrer on 26/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RightMenuType) {
    RightMenuTypeCough,
    RightMenuTypeUrine,
    RightMenuTypeDregs
};

@interface RightMenuViewController : UIViewController

@property (assign, nonatomic) RightMenuType rightMenuType;

- (void)setRightMenuType:(RightMenuType)rightMenuType;

@end
