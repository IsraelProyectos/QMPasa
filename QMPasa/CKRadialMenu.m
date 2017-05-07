//
//  CKRadialView.m
//  CKRadialMenu
//
//  Created by Cameron Klein on 12/7/14.
//  Copyright (c) 2014 Cameron Klein. All rights reserved.
//

#import "CKRadialMenu.h"
#import "NBInfiniteScrollView.h"
#import "ImageSequence.h"

@interface CKRadialMenu()

@property (nonatomic, strong) NSMutableDictionary *poputIDs;
@property (nonatomic, strong) UIView *positionView;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *distanceBetweenLabel;
@property (nonatomic, strong) UILabel *angleLabel;
@property (nonatomic, strong) UILabel *staggerLabel;
@property (nonatomic, strong) UILabel *animationLabel;
@end

@implementation CKRadialMenu

#pragma mark Initalizer


- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.popoutViews = [NSMutableArray new];
        self.poputIDs = [NSMutableDictionary new];
        self.menuIsExpanded = false;
        self.centerView = [UIView new]; // [self makeDefaultCenterView];
        self.containerView.frame = self.bounds;
        self.startAngle = -100;
        self.distanceBetweenPopouts = 50;
        self.distanceFromCenter = 125;
        self.stagger = 0.06;
        self.animationDuration = 0.4;
        
        [self addSubview:self.containerView];
    }
    
    return self;
}

#pragma mark Setters

- (void)setImage:(UIImage*)image atIndex:(NSUInteger)index {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setImage:image];
    [imageView setCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)];
    [imageView setTag:25];
    [imageView setTintColor:[UIColor whiteColor]];
    [self setTag:index + 1];
    
    [self setImageView:imageView];
    [self addSubview:imageView];
}

- (void) setCenterView:(UIView *)centerView {
    if (!centerView) {
        centerView = [self makeDefaultCenterView];
    }
    _containerView = centerView;
    UIGestureRecognizer *tap = [UITapGestureRecognizer new];
    [tap addTarget:self action:@selector(didTapCenterView:)];
    [self.containerView addGestureRecognizer:tap];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.containerView.frame = self.bounds;
    
}

#pragma mark Gesture Recognizers

- (void)didTapCenterView:(UITapGestureRecognizer*)sender {
    if ([self.radialMenuDelegate respondsToSelector:@selector(radialMenuSelected:)]) {
        [self.radialMenuDelegate radialMenuSelected:self];
    }
    
    if (self.menuIsExpanded) {
        [self retract];
    }
    else {
        [self expand];
    }
}

- (void) expand {
    [self.imageView setTintColor:[UIColor colorWithRed:251/255.f green:112/255.f blue:93/255.f alpha:1.f]];
    
    if (![self.radialMenuDelegate respondsToSelector:@selector(radialMenuShouldExpand:)] || [self.radialMenuDelegate radialMenuShouldExpand:self]) {
        NSInteger i = 0;
        for (UIView *subView in self.popoutViews) {
            
            subView.alpha = 0;
            [UIView animateWithDuration:self.animationDuration
                                  delay:self.stagger*i
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.4
                                options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                    subView.alpha = 1;
                                    subView.transform = [self getTransformForPopupViewAtIndex:i];
                                } completion:^(BOOL finished) {
                                    if ([self.radialMenuDelegate respondsToSelector:@selector(radialMenuDidExpand:)]) {
                                        [self.radialMenuDelegate radialMenuDidExpand:self];
                                    }
                                }];
            i++;
        }
        self.menuIsExpanded = true;
        
    }
}

- (void) retract {
    [self.imageView setTintColor:[UIColor whiteColor]];
    
    if (![self.radialMenuDelegate respondsToSelector:@selector(radialMenuShouldRetract:)] || [self.radialMenuDelegate radialMenuShouldRetract:self]) {
        NSInteger i = 0;
        for (UIView *subView in self.popoutViews) {
            
            [UIView animateWithDuration:self.animationDuration
                                  delay:self.stagger*i
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.4
                                options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                    subView.transform = CGAffineTransformIdentity;
                                    subView.alpha = 0;
                                } completion:^(BOOL finished) {
                                    if ([self.radialMenuDelegate respondsToSelector:@selector(radialMenuDidRetract:)]) {
                                        [self.radialMenuDelegate radialMenuDidRetract:self];
                                    }
                                }];
            i++;
        }
        self.menuIsExpanded = false;
    }
}

- (void)didTapPopoutView:(UITapGestureRecognizer *)sender {
    UIView *popout = sender.view;
    
    if ([self.radialMenuDelegate respondsToSelector:@selector(radialMenu:didSelectPopout:)]) {
        [self.radialMenuDelegate radialMenu:self didSelectPopout:popout];
    }
}

#pragma mark Popout Views

- (void)addPopoutView:(UIView *)popoutView withIndentifier:(NSString *)identifier tag:(NSInteger)tag andIndex:(NSUInteger)index {
    if (!popoutView){
        popoutView = [self makeDefaultPopupView:tag andIndex:index];
    }
    [self.popoutViews addObject:popoutView];
    [self.poputIDs setObject:popoutView forKey:identifier];
    
    UIGestureRecognizer *tap = [UITapGestureRecognizer new];
    [tap addTarget:self action:@selector(didTapPopoutView:)];
    [popoutView addGestureRecognizer:tap];
    popoutView.alpha = 0;
    [self addSubview:popoutView];
    [self sendSubviewToBack:popoutView];
    popoutView.center = CGPointMake(self.bounds.origin.x + self.bounds.size.width/2,self.bounds.origin.y + self.bounds.size.height/2);
}

-(UIView *)getPopoutViewWithIndentifier:(NSString *)identifier {
    return [self.poputIDs objectForKey:identifier];
}

#pragma mark Make Default Views

- (UIView*)makeDefaultCenterView {
    UIView *view = [UIView new];
    view.layer.cornerRadius = self.frame.size.width / 2;
    view.backgroundColor = [UIColor redColor];
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowOpacity = 0.6;
    view.layer.shadowRadius = 2.0;
    view.layer.shadowOffset = CGSizeMake(0, 3);
    return view;
}

- (UIView*)makeDefaultPopupView:(NSInteger)tag andIndex:(NSUInteger)index {
    if (tag == 1) {
        NSArray *imagesArray = @[@"regionDetailPain0", @"regionDetailPain1", @"regionDetailPain2",
                                 @"regionDetailPain3", @"regionDetailPain4"];
        
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, 35, 35);
        view.layer.cornerRadius = view.frame.size.width/2;
        view.backgroundColor = [UIColor clearColor];
        view.layer.shadowColor = [[UIColor blackColor] CGColor];
        view.layer.shadowOpacity = 0.6;
        view.layer.shadowRadius = 3.0;
        view.layer.shadowOffset = CGSizeMake(0, 3);
        
        NSString *imageName = [imagesArray objectAtIndex:index];
        UIImage *image = [UIImage imageNamed:imageName];
        ImageSequence *imageView = [[ImageSequence alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        [imageView setImage:image];
        [imageView setImageName:imageName];
        [imageView setCenter:CGPointMake(view.bounds.size.width / 2, view.bounds.size.height / 2)];
        [view addSubview:imageView];
        
        return view;
    }
    else if (tag == 6) {
        NSArray *imagesArray = @[@"", @"", @"regionDetailSwelling0", @"", @""];
        
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, 35, 35);
        view.layer.cornerRadius = view.frame.size.width/2;
        if (index == 2) {
            view.backgroundColor = [UIColor clearColor];
        }
        view.layer.shadowColor = [[UIColor blackColor] CGColor];
        view.layer.shadowOpacity = 0.6;
        view.layer.shadowRadius = 3.0;
        view.layer.shadowOffset = CGSizeMake(0, 3);
        
        NSString *imageName = [imagesArray objectAtIndex:index];
        UIImage *image = [UIImage imageNamed:imageName];
        ImageSequence *imageView = [[ImageSequence alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        [imageView setImage:image];
        [imageView setImageName:imageName];
        [imageView setCenter:CGPointMake(view.bounds.size.width / 2, view.bounds.size.height / 2)];
        [view addSubview:imageView];
        
        return view;
    }
    
    else if (tag == 2) {
        NSArray *imagesArray = @[@"regionDetailStabbingPain0", @"regionDetailStabbingPain1", @"regionDetailStabbingPain2",
                                 @"regionDetailStabbingPain3", @"regionDetailStabbingPain4"];
        
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, 35, 35);
        view.layer.cornerRadius = view.frame.size.width/2;
        view.backgroundColor = [UIColor clearColor];
        view.layer.shadowColor = [[UIColor blackColor] CGColor];
        view.layer.shadowOpacity = 0.6;
        view.layer.shadowRadius = 3.0;
        view.layer.shadowOffset = CGSizeMake(0, 3);
        
        NSString *imageName = [imagesArray objectAtIndex:index];
        UIImage *image = [UIImage imageNamed:imageName];
        ImageSequence *imageView = [[ImageSequence alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        [imageView setImage:image];
        [imageView setImageName:imageName];
        [imageView setCenter:CGPointMake(view.bounds.size.width / 2, view.bounds.size.height / 2)];
        [view addSubview:imageView];
        
        return view;
    }
    else {
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, 35, 35);
        view.layer.cornerRadius = view.frame.size.width/2;
        view.backgroundColor = [UIColor clearColor];
        view.layer.shadowColor = [[UIColor blackColor] CGColor];
        view.layer.shadowOpacity = 0.6;
        view.layer.shadowRadius = 3.0;
        view.layer.shadowOffset = CGSizeMake(0, 3);
        return view;
    }
}

#pragma mark Helper Methods

- (CGAffineTransform) getTransformForPopupViewAtIndex: (NSInteger) index {
    CGFloat newAngle = self.startAngle + (self.distanceBetweenPopouts * index);
    CGFloat deltaY = -self.distanceFromCenter * cos(newAngle / 100.0);
    CGFloat deltaX = self.distanceFromCenter * sin(newAngle / 100.0);
    return CGAffineTransformMakeTranslation(deltaX, deltaY);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(self.bounds, point)) {
        return true;
    }
    for (UIView *subView in self.popoutViews) {
        if (CGRectContainsPoint(subView.frame, point)) {
            return true;
        }
    }
    return false;
}


-(void)didPanPopout:(UIPanGestureRecognizer *)sender {
    UIView *view = sender.view;
    NSInteger i = [self.popoutViews indexOfObject:view];
    CGPoint point = [sender locationInView:self];
    CGFloat centerX = self.bounds.origin.x + self.bounds.size.width/2;
    CGFloat centerY = self.bounds.origin.y + self.bounds.size.height/2;
    if (sender.state == UIGestureRecognizerStateChanged) {
        
        // Do Calculations
        CGFloat deltaX = point.x - centerX;
        CGFloat deltaY = point.y - centerY;
        CGFloat angle = atan2(deltaX, -deltaY) * 180.0 / M_PI ;
        CGFloat distanceFromCenter = sqrt(pow(point.x - centerX, 2) + pow(point.y - centerY, 2));
        
        // Assign Results
        self.distanceFromCenter = distanceFromCenter;
        self.startAngle = angle - self.distanceBetweenPopouts * i;
        
        // Change Labels
        self.distanceLabel.text = [NSString stringWithFormat:@"Distance From Center: %.02f", self.distanceFromCenter];
        self.angleLabel.text = [NSString stringWithFormat:@"Start Angle: %.02f", self.startAngle];
        
        // Change Position of Views
        view.center = point;
        view.transform = CGAffineTransformIdentity;
        
        NSInteger i = 0;
        for (UIView *subView in self.popoutViews) {
            if (subView != view) {
                subView.transform = [self getTransformForPopupViewAtIndex:i];
            }
            i++;
        }
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        view.center = CGPointMake(centerX, centerY);
        NSInteger i = 0;
        for (UIView *subView in self.popoutViews) {
            subView.transform = [self getTransformForPopupViewAtIndex:i];
            i++;
        }
    }
}

@end
