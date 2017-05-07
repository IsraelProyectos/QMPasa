//
//  ButtonDown.m
//  QMPasa
//
//  Created by Israel Puyol on 6/8/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "ButtonDone.h"

@implementation ButtonDone

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.contentEdgeInsets = UIEdgeInsetsMake(23, 23, 23, 23);
}

@end
