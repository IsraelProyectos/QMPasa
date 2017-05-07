//
//  EssentialsViewController.h
//  QMPasa
//
//  Created by Carles Frias Ferrer on 30/06/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "RootViewController.h"

@interface EssentialsViewController : RootViewController

@property (strong, nonatomic) NSMutableArray *selectedRegions;

- (IBAction)btnDonePressed:(UIButton*)btnDone;

@end
