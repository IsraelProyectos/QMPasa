//
//  RecommendationsViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 28/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "RecommendationsViewController.h"

@interface RecommendationsViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (assign, nonatomic) BOOL isFirstTime;
@property (assign, nonatomic) NSUInteger currentPage;

@end

@implementation RecommendationsViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFirstTime = YES;
    
    self.currentPage = 1;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.isFirstTime) {
        NSArray *imagesarray = @[
                                 @"recommendationsBed",
                                 @"recommendationsDrink",
                                 ];
        
        [self.pageControl setNumberOfPages:imagesarray.count];
        
        [self.scrollView setDelegate:self];
        [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width * imagesarray.count, self.view.frame.size.height)];
        
        NSInteger i = 0;
        for (NSString *imageName in imagesarray) {
            UIImage *image = [UIImage imageNamed:imageName];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setClipsToBounds:YES];
            
            CGRect frame = imageView.frame;
            frame.origin.x = (self.scrollView.frame.size.width * i) + ((self.view.frame.size.width / 2) - (imageView.frame.size.width / 2));
            frame.origin.y = (self.view.frame.size.height / 2) - (imageView.frame.size.height / 2);
            [imageView setFrame:frame];
            
            [self.scrollView addSubview:imageView];
            
            i++;
        }
        
        self.isFirstTime = NO;
    }
}

#pragma mark - IBActions

- (IBAction)btnDonePressed:(UIButton*)btnDone {
    if (self.currentPage == 2) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width * self.currentPage, 0.0f) animated:YES];
    
    [self.pageControl setCurrentPage:self.currentPage];
    self.currentPage++;
}

@end
