//
//  AuxiliarLeftMenuView.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 01/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "AuxiliarLeftMenuView.h"

@interface AuxiliarLeftMenuView()

@property (weak, nonatomic) IBOutlet UIButton *btnOpenDrawer;

@end

@implementation AuxiliarLeftMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"AuxiliarLeftMenuView" owner:self options:nil] firstObject];
        
        [self setupView];
    }
    
    return self;
}

#pragma mark - IBActions

- (IBAction)btnOpenDrawerPressed:(UIButton*)btnOpenDrawer {
    if ([self.delegate respondsToSelector:@selector(auxiliarLeftMenuView:didPressOpenDrawerButton:)]) {
        [self.delegate auxiliarLeftMenuView:self didPressOpenDrawerButton:btnOpenDrawer];
    }
}

#pragma mark - Private methods

- (void)setupView {
}

@end
