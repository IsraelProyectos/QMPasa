//
//  NBInfiniteScrollView.m
//
//  Created by Nathaniel Brown on 11/12/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "NBInfiniteScrollView.h"
#import "CKRadialMenu.h"

@interface NBInfiniteScrollView () <CKRadialMenuDelegate>

@property (strong, nonatomic) NSMutableArray *visibleViews;
@property (strong, nonatomic) UIView *containerView;
@property (assign, nonatomic) NSInteger min, max;

@property (strong, nonatomic) CKRadialMenu *previousRadialMenu;

@end

@implementation NBInfiniteScrollView

- (void)setVertical:(BOOL)vertical {
    _vertical = vertical;
    
    if (self.vertical) {
        self.contentSize = CGSizeMake(self.frame.size.width, 5000);
    }
    else {
        self.contentSize = CGSizeMake(5000, self.frame.size.height);
    }
    
    self.containerView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
}

- (void)internalInit {
    self.count = 6;
    self.vertical = self.frame.size.width < self.frame.size.height;
    self.min = self.max = 0;
    self.padding = UIEdgeInsetsZero;
    
    if (self.vertical) {
        self.contentSize = CGSizeMake(self.frame.size.width, 5000);
    }
    else {
        self.contentSize = CGSizeMake(5000, self.frame.size.height);
    }
    
    self.visibleViews = [[NSMutableArray alloc] init];
    self.containerView = [[UIView alloc] init];
    self.containerView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    [self addSubview:self.containerView];
    
    // hide scroll indicators so our recentering tricks are not revealed
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = NO;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self internalInit];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self internalInit];
    }
    
    return self;
}

#pragma mark Layout

// recenter content periodically to achieve impression of infinite scrolling
- (void)recenterIfNecessary {
    CGPoint currentOffset = [self contentOffset];
    if (_vertical) {
        CGFloat contentWidth = [self contentSize].height;
        CGFloat centerOffsetX = (contentWidth - [self bounds].size.height) / 2.0;
        CGFloat distanceFromCenter = fabs(currentOffset.y - centerOffsetX);
        
        if (distanceFromCenter > (contentWidth / 4.0)) {
            self.contentOffset = CGPointMake(currentOffset.x, centerOffsetX);
            
            // move content by the same amount so it appears to stay still
            for (UIView *view in self.visibleViews) {
                CGPoint center = [self.containerView convertPoint:view.center toView:self];
                center.y += (centerOffsetX - currentOffset.y);
                view.center = [self convertPoint:center toView:self.containerView];
            }
        }
    } else {
        CGFloat contentWidth = [self contentSize].width;
        CGFloat centerOffsetX = (contentWidth - [self bounds].size.width) / 2.0;
        CGFloat distanceFromCenter = fabs(currentOffset.x - centerOffsetX);
        
        if (distanceFromCenter > (contentWidth / 4.0)) {
            self.contentOffset = CGPointMake(centerOffsetX, currentOffset.y);
            
            // move content by the same amount so it appears to stay still
            for (UIView *view in self.visibleViews) {
                CGPoint center = [self.containerView convertPoint:view.center toView:self];
                center.x += (centerOffsetX - currentOffset.x);
                view.center = [self convertPoint:center toView:self.containerView];
            }
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self recenterIfNecessary];
    
    // tile content in visible bounds
    CGRect visibleBounds = [self convertRect:[self bounds] toView:self.containerView];
    CGFloat minimumVisible, maximumVisible;
    
    minimumVisible = _vertical ? CGRectGetMinY(visibleBounds) : CGRectGetMinX(visibleBounds);
    maximumVisible = _vertical ? CGRectGetMaxY(visibleBounds) : CGRectGetMaxX(visibleBounds);
    
    [self tileViewsFromMin:minimumVisible toMax:maximumVisible];
}

#pragma mark View Tiling

- (UIView *)insertView:(NSUInteger)index {
    NSArray *imagesArray = @[@"regionDetailPain", @"regionDetailStabbingPain", @"regionDetailBulges",
                             @"regionDetailWound", @"regionDetailSecretion", @"regionDetailSwelling"];
    
    UIView *v;
    if (nil != _viewForIndex) {
        v = _viewForIndex(index);
    }
    else {
        NSString *imageName = [imagesArray objectAtIndex:index];
        UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        CKRadialMenu *radialView = [[CKRadialMenu alloc] initWithFrame:CGRectMake(self.containerView.center.x, self.containerView.frame.size.height, 75, 75)];
        [radialView setImage:image atIndex:index];
        [radialView setRadialMenuDelegate:self];
        
        if (radialView.tag == 1) {
            index = 0;
            [radialView addPopoutView:nil withIndentifier:@"ONE" tag:radialView.tag andIndex:index];
            [radialView addPopoutView:nil withIndentifier:@"TWO" tag:radialView.tag andIndex:index + 1];
            [radialView addPopoutView:nil withIndentifier:@"THREE" tag:radialView.tag andIndex:index + 2];
            [radialView addPopoutView:nil withIndentifier:@"FOUR" tag:radialView.tag andIndex:index + 3];
            [radialView addPopoutView:nil withIndentifier:@"FIVE" tag:radialView.tag andIndex:index + 4];
            [self.containerView addSubview:radialView];
            return radialView;
        }
        else if (radialView.tag == 2) {
            index = 0;
            [radialView addPopoutView:nil withIndentifier:@"ONE" tag:radialView.tag andIndex:index];
            [radialView addPopoutView:nil withIndentifier:@"TWO" tag:radialView.tag andIndex:index + 1];
            [radialView addPopoutView:nil withIndentifier:@"THREE" tag:radialView.tag andIndex:index + 2];
            [radialView addPopoutView:nil withIndentifier:@"FOUR" tag:radialView.tag andIndex:index + 3];
            [radialView addPopoutView:nil withIndentifier:@"FIVE" tag:radialView.tag andIndex:index + 4];
            [self.containerView addSubview:radialView];
            return radialView;            
        }
        else if (radialView.tag == 3) {
            [self.containerView addSubview:radialView];
            return radialView;
        }
        else if (radialView.tag == 4) {
            [self.containerView addSubview:radialView];
            return radialView;
        }
        else if (radialView.tag == 5) {
            [self.containerView addSubview:radialView];
            return radialView;
        }
        else if (radialView.tag == 6) {
            index = 0;
            [radialView addPopoutView:nil withIndentifier:@"ONE" tag:radialView.tag andIndex:index];
            [radialView addPopoutView:nil withIndentifier:@"TWO" tag:radialView.tag andIndex:index + 1];
            [radialView addPopoutView:nil withIndentifier:@"THREE" tag:radialView.tag andIndex:index + 2];
            [radialView addPopoutView:nil withIndentifier:@"FOUR" tag:radialView.tag andIndex:index + 3];
            [radialView addPopoutView:nil withIndentifier:@"FIVE" tag:radialView.tag andIndex:index + 4];
            [self.containerView addSubview:radialView];
            return radialView;
        }
    }
    return v;
}

- (void)radialMenuSelected:(CKRadialMenu *)radialMenu {
    if (self.previousRadialMenu && ![self.previousRadialMenu isEqual:radialMenu]) {
        [self.previousRadialMenu retract];
    }
    
    CGFloat midScreen = self.superview.frame.size.width / 2;
    CGFloat scrollInitialOffset = self.contentOffset.x;
    CGFloat radialMenuWidthCorrection = radialMenu.frame.size.width / 2;
    CGFloat radialMenuXOrigin = radialMenu.frame.origin.x + radialMenuWidthCorrection;
    CGFloat radialMenuXOffset = scrollInitialOffset - radialMenuXOrigin;
    CGFloat scrollContentOffsetX = scrollInitialOffset - radialMenuXOffset - midScreen;
    
    [self setContentOffset:CGPointMake(scrollContentOffsetX, 0) animated:YES];
    
    self.previousRadialMenu = radialMenu;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *subview in self.subviews.firstObject.subviews.reverseObjectEnumerator) {
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        CKRadialMenu *radialMenu = (CKRadialMenu*) [subview hitTest:subPoint withEvent:event];
        
        if (radialMenu) {
            return radialMenu;
        }
    }
    
    return nil;
}

- (void)radialMenu:(CKRadialMenu *)radialMenu didSelectPopout:(UIView *)popout {
    if ([self.infiniteScrollViewDelegate respondsToSelector:@selector(infiniteScrollView:didSelectPopout:fromRadialMenu:)]) {
        [self.infiniteScrollViewDelegate infiniteScrollView:self didSelectPopout:popout fromRadialMenu:radialMenu];
    }
}

- (CGFloat)placeNewViewOnRight:(CGFloat)rightEdge withIndex:(NSUInteger)index {
    UIView *view = [self insertView:index];
    [self.visibleViews addObject:view]; // add rightmost view at the end of the array
    
    CGRect frame = [view frame];
    if (_vertical) {
        frame.origin.x = (([self.containerView bounds].size.width - frame.size.width - _padding.left - _padding.right)/2.0) + _padding.left;
        frame.origin.y = rightEdge + _padding.top;
    } else {
        frame.origin.x = rightEdge + _padding.left;
        frame.origin.y = (([self.containerView bounds].size.height - frame.size.height - _padding.top - _padding.bottom)/2.0) + _padding.top;
    }
    [view setFrame:frame];
    
    return _vertical ? (CGRectGetMaxY(frame) + _padding.bottom) : (CGRectGetMaxX(frame) + _padding.right);
    
}

- (CGFloat)placeNewViewOnLeft:(CGFloat)leftEdge withIndex:(NSUInteger)index {
    UIView *view = [self insertView:index];
    [self.visibleViews insertObject:view atIndex:0]; // add leftmost view at the beginning of the array
    
    CGRect frame = [view frame];
    if (_vertical) {
        frame.origin.x = (([self.containerView bounds].size.width - frame.size.width - _padding.left - _padding.right)/2.0) + _padding.left;
        frame.origin.y = leftEdge - frame.size.height - _padding.bottom;
    } else {
        frame.origin.x = leftEdge - frame.size.width - _padding.right;
        frame.origin.y = (([self.containerView bounds].size.height - frame.size.height - _padding.top - _padding.bottom)/2.0) + _padding.top;
    }
    [view setFrame:frame];
    
    return _vertical ? (CGRectGetMinY(frame) - _padding.top) : (CGRectGetMinX(frame) - _padding.left);
    
}

- (void)tileViewsFromMin:(CGFloat)minimumVisible toMax:(CGFloat)maximumVisible {
    // the upcoming tiling logic depends on there already being at least one view in the visibleViews array, so
    // to kick off the tiling we need to make sure there's at least one view
    if ([self.visibleViews count] == 0) {
        [self placeNewViewOnRight:minimumVisible withIndex:0];
    }
    
    // add views that are missing on right side
    UIView *lastView = [self.visibleViews lastObject];
    CGFloat rightEdge = _vertical ? (CGRectGetMaxY([lastView frame]) + _padding.bottom) :
    (CGRectGetMaxX([lastView frame]) + _padding.right);
    while (rightEdge < maximumVisible) {
        rightEdge = [self placeNewViewOnRight:rightEdge withIndex:(++_max > _count-1 ? (_max=0) : _max)];
    }
    
    // add views that are missing on left side
    UIView *firstView = [self.visibleViews objectAtIndex:0];
    CGFloat leftEdge = _vertical ? (CGRectGetMinY([firstView frame]) - _padding.top) :
    (CGRectGetMinX([firstView frame]) - _padding.left);
    while (leftEdge > minimumVisible) {
        leftEdge = [self placeNewViewOnLeft:leftEdge withIndex:(--_min < 0 ? (_min=_count-1) : _min)];
    }
    
    // remove views that have fallen off right edge
    lastView = [self.visibleViews lastObject];
    while ((_vertical ? [lastView frame].origin.y : [lastView frame].origin.x) > maximumVisible) {
        if (--_max < 0) _max = _count-1;
        [lastView removeFromSuperview];
        [self.visibleViews removeLastObject];
        lastView = [self.visibleViews lastObject];
    }
    
    // remove views that have fallen off left edge
    firstView = [self.visibleViews objectAtIndex:0];
    while ((_vertical ? CGRectGetMaxY([firstView frame]) : CGRectGetMaxX([firstView frame])) < minimumVisible) {
        if (++_min > _count-1) _min=0;
        [firstView removeFromSuperview];
        [self.visibleViews removeObjectAtIndex:0];
        firstView = [self.visibleViews objectAtIndex:0];
    }
}

@end
