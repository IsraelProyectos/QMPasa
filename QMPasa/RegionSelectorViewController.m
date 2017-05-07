//
//  MainViewController.m
//  QueMePasa
//
//  Created by isra on 22/6/16.
//  Copyright © 2016 Israel. All rights reserved.
//

#import "RegionSelectorViewController.h"
#import "ImageSequence.h"
#import "EssentialsViewController.h"
#import "RegionPoint.h"

@interface RegionSelectorViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageHenry;

@property (strong, nonatomic) EssentialsViewController *parentController;
@property (assign, nonatomic) BOOL isShowingFront;
@property (strong, nonatomic) NSMutableArray *showingPoints;

@end

@implementation RegionSelectorViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parentController = (EssentialsViewController*) self.parentViewController;
    self.isShowingFront = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadPoints];
}

#pragma mark - IBActions

- (IBAction)btnFlipHenryPressed:(UIButton*)btnFlipHenry {
    self.isShowingFront = !self.isShowingFront;
    
    if (self.isShowingFront){
        [self.imageHenry setImage:[UIImage imageNamed:@"regionSelectorHenryNudeFront"]];
    }
    else {
        [self.imageHenry setImage:[UIImage imageNamed:@"regionSelectorHenryNudeBehind"]];
    }
    
    [self loadPoints];
}

- (void)btnPointPressed:(UITapGestureRecognizer*)gestureRecognizer {
    ImageSequence *image = (ImageSequence*) gestureRecognizer.view;
    UIImage *img4 = [[UIImage imageNamed:@"regionSelectorDiana2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    if (image.isAnimating) {
        [image stopAnimating];
        [image setImage:img4];
        [image setTintColor:[UIColor grayColor]];
        
        [self.parentController.selectedRegions addObject:image.regionPoint.region];
    }
    else {
        [image startAnimating];
        
        [self.parentController.selectedRegions removeObject:image.regionPoint.region];
    }
}

#pragma mark - Private methods

- (void)loadPoints {
    if (self.showingPoints) {
        for (UIView *view in self.showingPoints) {
            [view removeFromSuperview];
        }
    }
    
    if (self.isShowingFront) {
        NSArray *points = [RegionPoint where:@{@"general": @(YES)}];
        NSUInteger delay = 0;
        
        for (RegionPoint *point in points) {
            ImageSequence *imageSequence = [[ImageSequence alloc] initWithName:@"diana" atPoint:CGPointMake([point.superX floatValue], [point.superY floatValue]) withDelay:delay toView:self.view];
            [imageSequence setRegionPoint:point];
            
            UITapGestureRecognizer *tapGestureRecognizer =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnPointPressed:)];
            [tapGestureRecognizer setNumberOfTapsRequired:1];
            [imageSequence addGestureRecognizer:tapGestureRecognizer];
            
            [self.showingPoints addObject:imageSequence];
            [self.view addSubview:imageSequence];
            
            delay++;
        }
    }
    else {
        // Back view of Henry
    }
}

@end
