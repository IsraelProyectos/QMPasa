//
//  ResultadoInmediatoViewController.m
//  HaztePruebasViewController
//
//  Created by isra on 27/7/16.
//  Copyright © 2016 Israel. All rights reserved.
//

#import "ResultadoInmediatoViewController.h"
#import "ReminderViewController.h"
#import "RecommendationsViewController.h"

@interface ResultadoInmediatoViewController ()

@end

@implementation ResultadoInmediatoViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - IBActions

- (IBAction)btnAlarmPressed:(id)sender {
    ReminderViewController *reminderController = [[ReminderViewController alloc] init];
    [self presentViewController:reminderController animated:YES completion:nil];
}

- (IBAction)btnPhone:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:@"000"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (IBAction)btnPoints:(id)sender {
    RecommendationsViewController *recomendationsController = [[RecommendationsViewController alloc] init];
    [self presentViewController:recomendationsController animated:YES completion:nil];
}

@end
