//
//  RegionDetailViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 04/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "RegionDetailViewController.h"
#import "NBInfiniteScrollView.h"
#import "Constants.h"
#import "CKRadialMenu.h"
#import "OverviewViewController.h"
#import "RightMenuViewController.h"
#import "ImageSequence.h"
#import "Region.h"
#import "RegionPoint.h"
#import "PointImage.h"

@interface RegionDetailViewController () <NBInfiniteScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *regionsScrollView;
@property (weak, nonatomic) IBOutlet NBInfiniteScrollView *infiniteScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSArray *regions;
@property (strong, nonatomic) ImageSequence *selectedPoint;
@property (assign, nonatomic) NSUInteger currentPage;
@property (strong, nonatomic) Region *currentRegion;

@end

@implementation RegionDetailViewController

#pragma mark - UIViewController lifecycle

- (instancetype)initWithRegions:(NSArray*)regions {
    self = [super init];
    
    if (self) {
        self.regions = regions;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.infiniteScrollView setInfiniteScrollViewDelegate:self];
    [self.pageControl setNumberOfPages:self.regions.count];
    
    NSArray *allPoints = [RegionPoint all];
    for (RegionPoint *point in allPoints) {
        [point setImages:nil];
        [point save];
    }
    
    [PointImage deleteAll];
    
    self.currentPage = 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadRegionsWithPoints];
}

#pragma mark - NBInfiniteScrollView delegates

- (void)infiniteScrollView:(NBInfiniteScrollView *)infiniteScrollView didSelectPopout:(UIView *)popout fromRadialMenu:(CKRadialMenu *)radialMenu {
    if (self.selectedPoint) {
        ImageSequence *imageSequence = [popout.subviews firstObject];
        UIImage *popoutImage = imageSequence.image;
        RegionPoint *selectedRegionPoint = self.selectedPoint.regionPoint;
        
        if ([self.selectedPoint.imageName isEqualToString:@"regionSelectorDiana0"]) {
            [self.selectedPoint setImage:popoutImage];
            [self.selectedPoint setImageName:imageSequence.imageName];
        }
        else {
            
            CGPoint point = CGPointMake([selectedRegionPoint.x floatValue], [selectedRegionPoint.y floatValue]);
            [self addImage:popoutImage ofRegionPoint:self.selectedPoint.regionPoint toView:self.selectedPoint.superview atCoordinates:point];
        }
        
        PointImage *pointImage = [PointImage create:@{@"name": imageSequence.imageName}];
        if (![[selectedRegionPoint.images allObjects] containsObject:pointImage]) {
            [selectedRegionPoint addImagesObject:pointImage];
            [selectedRegionPoint save];
        }
    }
}

#pragma mark - IBActions

- (IBAction)btnDonePressed:(UIButton*)btnDone {
    if (self.currentPage == self.regions.count) {
        [self prepareOverviewViewController];
        return;
    }
    
    self.selectedPoint = nil;
    [self.regionsScrollView setContentOffset:CGPointMake(self.view.frame.size.width * self.currentPage, 0.0f) animated:YES];
    
    [self.pageControl setCurrentPage:self.currentPage];
    self.currentPage++;
}

#pragma mark - Private methods

- (void)loadRegionsWithPoints {
    [self.infiniteScrollView setVertical:NO];
    [self.infiniteScrollView setPadding:UIEdgeInsetsMake(5, 5, 5, 5)];
    [self.infiniteScrollView setClipsToBounds:NO];
    
    [self.regionsScrollView setContentSize:CGSizeMake(self.view.frame.size.width * self.regions.count, self.view.frame.size.height * 0.8)];
    [self.infiniteScrollView setContentSize:CGSizeMake(self.infiniteScrollView.contentSize.width, self.view.frame.size.height * 0.2)];
    
    NSUInteger i = 0;
    for (Region *region in self.regions) {
        RegionType regionType = [region.regionId integerValue];
        NSString *imageString;
        NSArray *points = [region.points allObjects];
        
        switch (regionType) {
            case RegionTypeHead: {
                imageString = @"regionDetailRegionHead";
                break;
            }
            case RegionTypeFace: {
                imageString = @"regionDetailRegionFace";
                break;
            }
            case RegionTypeNeck: {
                imageString = @"regionDetailRegionNeck";
                break;
            }
            case RegionTypeBack: {
                imageString = @"regionDetailRegionBack";
                break;
            }
            case RegionTypeTorax: {
                imageString = @"regionDetailRegionTorax";
                break;
            }
            case RegionTypeArm: {
                imageString = @"regionDetailRegionArm";
                break;
            }
            case RegionTypeHand: {
                imageString = @"regionDetailRegionHand";
                break;
            }
            case RegionTypeAbdomen: {
                imageString = @"regionDetailRegionAbdomen";
                break;
            }
            case RegionTypeHip: {
                imageString = @"regionDetailRegionHip";
                break;
            }
            case RegionTypeAss: {
                imageString = @"regionDetailRegionAss";
                break;
            }
            case RegionTypeGenitals: {
                imageString = @"regionDetailRegionGenitals";
                break;
            }
            case RegionTypeLeg: {
                imageString = @"regionDetailRegionLeg";
                break;
            }
            case RegionTypeFoot: {
                imageString = @"regionDetailRegionFoot";
                break;
            }
        }
        
        UIImage *image = [UIImage imageNamed:imageString];
        ImageSequence *imageView = [[ImageSequence alloc] initWithImage:image];
        [imageView setUserInteractionEnabled:YES];
        [imageView setCenter:CGPointMake(self.view.bounds.size.width / 2, (self.view.frame.size.height * 0.8) / 2)];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setImage:image];
        [imageView setBackgroundColor:[UIColor darkGrayColor]];
        
        CGRect frame = imageView.frame;
        frame.origin.x = (self.view.bounds.size.width * i) + ((self.view.bounds.size.width / 2) - (imageView.frame.size.width / 2));
        [imageView setFrame:frame];
        
        for (RegionPoint *point in points) {
            CGFloat x = [point.x floatValue];
            CGFloat y = [point.y floatValue];
            
            UIImage *pointImage = [[UIImage imageNamed:@"regionSelectorDiana0"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            ImageSequence *ivPoint = [self addImage:pointImage ofRegionPoint:point toView:imageView atCoordinates:CGPointMake(x, y)];
            [ivPoint setTintColor:[UIColor orangeColor]];
            [ivPoint setImageName:@"regionSelectorDiana0"];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRegionPointPressed:)];
            [ivPoint addGestureRecognizer:tapGesture];
        }
        
        [self.regionsScrollView addSubview:imageView];
        
        i++;
    }
}

- (void)onRegionPointPressed:(UITapGestureRecognizer*)tapGesture {
    ImageSequence *imageSequence = (ImageSequence*) tapGesture.view;
    
    if (![self.selectedPoint isEqual:imageSequence]) {
        if (self.selectedPoint.regionPoint.images.count == 0) {
            [self.selectedPoint setTintColor:[UIColor orangeColor]];
        }
    }
    
    self.selectedPoint = imageSequence;
    [self.selectedPoint setTintColor:[UIColor grayColor]];
}

- (void)prepareOverviewViewController {
    RightMenuViewController *rightViewController = [[RightMenuViewController alloc] init];
    [self.mm_drawerController setRightDrawerViewController:rightViewController];
    
    OverviewViewController *overviewController = [[OverviewViewController alloc] init];
    [self.mm_drawerController setCenterViewController:overviewController];
    [overviewController.view addSubview:self.view];
    
    [UIView animateWithDuration:0.75 delay:0.15 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.view.alpha = 0;
    }
    completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

- (ImageSequence*)addImage:(UIImage*)image ofRegionPoint:(RegionPoint*)regionPoint toView:(UIView*)superview atCoordinates:(CGPoint)point {
    ImageSequence *ivPoint = [[ImageSequence alloc] initWithImage:image];
    [ivPoint setUserInteractionEnabled:YES];
    [ivPoint setCenter:CGPointMake(superview.bounds.size.width / 2, superview.frame.size.height / 2)];
    [ivPoint setContentMode:UIViewContentModeScaleAspectFit];
    [ivPoint setImage:image];
    
    [ivPoint setRegionPoint:regionPoint];
    
    CGRect pointFrame = ivPoint.frame;
    pointFrame.origin.x += point.x;
    pointFrame.origin.y += point.y;
    [ivPoint setFrame:pointFrame];
    
    [superview addSubview:ivPoint];
    
    return ivPoint;
}

@end
