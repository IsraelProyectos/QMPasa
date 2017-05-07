//
//  RightMenuTableViewCell.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 26/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "RightMenuTableViewCell.h"

@implementation RightMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *selectedView = [[UIView alloc] initWithFrame:self.frame];
    [selectedView setBackgroundColor:[UIColor colorWithRed:251/255.f green:112/255.f blue:93/255.f alpha:1.f]];
    [self setSelectedBackgroundView:selectedView];
    
    UIImage *peeImage = [[UIImage imageNamed:@"overviewPee"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.imvPee setImage:peeImage];
    
    [self.imvPee setHidden:YES];
    [self.imvPeeBlood setHidden:YES];
    [self.imvPeeStinky setHidden:YES];
    [self.imvDregs setHidden:YES];
}

@end
