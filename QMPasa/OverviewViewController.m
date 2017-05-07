//
//  OverviewViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 26/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "OverviewViewController.h"
#import "RightMenuViewController.h"
#import "ImageSequence.h"
#import "PointImage.h"
#import "RegionPoint.h"
#import "QuestionsViewController.h"

@interface OverviewViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imvMan;

@end

@implementation OverviewViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *allPoints = [RegionPoint all];
    for (RegionPoint *point in allPoints) {
        if (point.images.count > 0) {
            [self loadPointImages:point];
        }
    }
}

#pragma mark - IBActions

- (IBAction)btnRightMenuPressed:(UIButton*)btnRightMenu {
    RightMenuViewController *rightController = (RightMenuViewController*) self.mm_drawerController.rightDrawerViewController;
    NSUInteger tag = btnRightMenu.tag;
    [rightController setRightMenuType:tag];
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (IBAction)btnDonePressed:(UIButton*)btnDone {
    QuestionsViewController *resultsController = [[QuestionsViewController alloc] init];
    [self.mm_drawerController setCenterViewController:resultsController];
    [resultsController.view addSubview:self.view];
    
    [UIView animateWithDuration:0.75 delay:0.15 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.view.alpha = 0;
    }
    completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

#pragma mark - Private methods

- (void)loadPointImages:(RegionPoint*)regionPoint {
    NSArray *allImages = [regionPoint.images allObjects];
    for (PointImage *pointImage in allImages) {
        UIImage *image = [UIImage imageNamed:pointImage.name];
        ImageSequence *ivPoint = [[ImageSequence alloc] initWithImage:image];
        [ivPoint setUserInteractionEnabled:YES];
        [ivPoint setCenter:CGPointMake(self.imvMan.bounds.size.width / 2, self.imvMan.frame.size.height / 2)];
        [ivPoint setContentMode:UIViewContentModeScaleAspectFit];
        [ivPoint setImage:image];
        
        [ivPoint setRegionPoint:regionPoint];
        
        CGRect pointFrame = ivPoint.frame;
        pointFrame.origin.x += [regionPoint.superX floatValue];
        pointFrame.origin.y += [regionPoint.superY floatValue];
        [ivPoint setFrame:pointFrame];
        
        [self.imvMan addSubview:ivPoint];
    }
}

@end
