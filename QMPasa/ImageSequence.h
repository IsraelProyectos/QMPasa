//
//  ImageSequence.h
//  QueMePasa
//
//  Created by isra on 23/6/16.
//  Copyright © 2016 Israel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "RegionPoint.h"

@interface ImageSequence : UIImageView

- (instancetype)initWithName:(NSString*)name atPoint:(CGPoint)point withDelay:(NSUInteger)delay toView:(UIView*)view;

@property (strong, nonatomic) RegionPoint *regionPoint;
@property (strong, nonatomic) NSString *imageName;

@end
