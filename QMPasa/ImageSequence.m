//
//  ImageSequence.m
//  QueMePasa
//
//  Created by isra on 23/6/16.
//  Copyright © 2016 Israel. All rights reserved.
//

#import "ImageSequence.h"

@implementation ImageSequence

#pragma mark - UIView lifecycle

- (instancetype)initWithName:(NSString*)name atPoint:(CGPoint)point withDelay:(NSUInteger)delay toView:(UIView*)view {
    self = [super init];
    
    if (self) {
        [self setupViewWithName:name atPoint:point withDelay:delay toView:view];
    }
    
    return self;
}

#pragma mark - Private methods

- (void)setupViewWithName:(NSString*)name atPoint:(CGPoint)point withDelay:(NSUInteger)delay toView:(UIView*)view {
    [self setUserInteractionEnabled:YES];
    
    NSArray *images;
    
    CGSize viewSize = view.frame.size;
    CGFloat midX = viewSize.width / 2;
    CGFloat midY = viewSize.height / 2;
    
    CGFloat proportionalXOffset = viewSize.width / 320;
    CGFloat proportionalYOffset = viewSize.height / 480;
    
    if ([name isEqualToString:@"diana"]) {
        UIImage *img0 = [UIImage imageNamed:@"regionSelectorDiana0"];
        UIImage *img1 = [UIImage imageNamed:@"regionSelectorDiana1"];
        UIImage *img2 = [UIImage imageNamed:@"regionSelectorDiana2"];
        UIImage *img3 = [UIImage imageNamed:@"regionSelectorDiana1"];
        UIImage *img4 = [UIImage imageNamed:@"regionSelectorDiana0"];
        
        images = @[img0, img1, img2, img3, img4, img3, img2, img1, img0];
    }
    
    CGFloat originX = point.x;
    CGFloat originY = point.y;
    originX *= proportionalXOffset;
    originY *= proportionalYOffset;
    
    CGRect frame = CGRectMake(midX + originX - 30, midY + originY - 30, 60, 60);
    [self setFrame:frame];
    
    [self setAnimationImages:images];
    [self setAnimationRepeatCount:0];
    [self setAnimationDuration:3];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimating];
    });
}



@end
