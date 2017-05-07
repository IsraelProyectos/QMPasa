//
//  QuestionsViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 28/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "QuestionsViewController.h"
#import "ResultadoInmediatoViewController.h"

@interface QuestionsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;

@end

@implementation QuestionsViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - IBActions

- (IBAction)btnDonePressed:(UIButton*)btnDone {
    ResultadoInmediatoViewController *resultController = [[ResultadoInmediatoViewController alloc] init];
    [self.mm_drawerController setCenterViewController:resultController];
    [resultController.view addSubview:self.view];
    
    [UIView animateWithDuration:0.75 delay:0.15 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.view.alpha = 0;
    }
    completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

#pragma mark - Private methods

@end
