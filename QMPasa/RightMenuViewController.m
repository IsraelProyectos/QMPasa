//
//  RightMenuViewController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 26/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "RightMenuViewController.h"
#import "RightMenuTableViewCell.h"

@interface RightMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *cough;
@property (strong, nonatomic) NSArray *urine;
@property (strong, nonatomic) NSArray *dregs;
@property (assign, nonatomic) NSInteger coughSelectedIndex;
@property (assign, nonatomic) NSInteger urineSelectedIndex;
@property (assign, nonatomic) NSInteger dregsSelectedIndex;

@end

@implementation RightMenuViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.urine = @[
                 [self colorWithRGB:@"239,190,0"],
                 [self colorWithRGB:@"244,235,192"],
                 [self colorWithRGB:@"239,190,0"],
                 [self colorWithRGB:@"187,4,28"],
                 [self colorWithRGB:@"244,235,192"]
                 ];
    
    self.coughSelectedIndex = self.urineSelectedIndex = self.dregsSelectedIndex = -1;
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView registerNib:[UINib nibWithNibName:@"RightMenuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.rightMenuType) {
        case RightMenuTypeCough:
            return 4;
            
        case RightMenuTypeUrine:
            return self.urine.count;
            
        case RightMenuTypeDregs:
            return 9;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RightMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.rightMenuType == RightMenuTypeCough) {
        [cell.imvMan setImage:[UIImage imageNamed:@"overviewCough0"]];
        [cell.imvDregs setHidden:YES];
        [cell.imvPee setHidden:YES];
        [cell.imvPeeBlood setHidden:YES];
        [cell.imvPeeStinky setHidden:YES];
    }
    
    if (self.rightMenuType == RightMenuTypeUrine) {
        UIColor *color = [self.urine objectAtIndex:indexPath.row];
        [cell.imvMan setImage:[UIImage imageNamed:@"overviewManNormal"]];
        
        [cell.imvDregs setHidden:YES];
        
        [cell.imvPee setHidden:NO];
        [cell.imvPee setTintColor:color];
        
        if (indexPath.row == 0) {
            [cell.imvPeeBlood setHidden:NO];
        }
        else {
            [cell.imvPeeBlood setHidden:YES];
        }
        
        if (indexPath.row == (self.urine.count - 1)) {
            [cell.imvPeeStinky setHidden:NO];
        }
        else {
            [cell.imvPeeStinky setHidden:YES];
        }
    }
    
    if (self.rightMenuType == RightMenuTypeDregs) {
        if (indexPath.row == 8) {
            [cell.imvMan setImage:[UIImage imageNamed:@"overviewManHappy"]];
        }
        else {
            [cell.imvMan setImage:[UIImage imageNamed:@"overviewManPain"]];
        }
        
        [cell.imvPee setHidden:YES];
        [cell.imvPeeBlood setHidden:YES];
        [cell.imvPeeStinky setHidden:YES];
        
        [cell.imvDregs setHidden:NO];
        
        [cell.imvDregs setImage:[UIImage imageNamed:[NSString stringWithFormat:@"overviewDregs%li", (long) indexPath.row]]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.rightMenuType) {
        case RightMenuTypeCough:
            [cell setSelected:self.coughSelectedIndex == indexPath.row];
            break;
            
        case RightMenuTypeUrine:
            [cell setSelected:self.urineSelectedIndex == indexPath.row];
            break;
            
        case RightMenuTypeDregs:
            [cell setSelected:self.dregsSelectedIndex == indexPath.row];
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 242;
}

#pragma mark - UITableView delegates

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.rightMenuType) {
        case RightMenuTypeCough:
            self.coughSelectedIndex = indexPath.row;
            break;
            
        case RightMenuTypeUrine:
            self.urineSelectedIndex = indexPath.row;
            break;
            
        case RightMenuTypeDregs:
            self.dregsSelectedIndex = indexPath.row;
            break;
    }
    
    [tableView reloadData];
}

#pragma mark - Private methods

- (UIColor*)colorWithRGB:(NSString*)RGBString {
    NSArray *RGB = [RGBString componentsSeparatedByString:@","];
    NSUInteger red = [[RGB firstObject] integerValue];
    NSUInteger green = [[RGB objectAtIndex:1] integerValue];
    NSUInteger blue = [[RGB lastObject] integerValue];
    
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.f];
}

- (void)setRightMenuType:(RightMenuType)rightMenuType {
    _rightMenuType = rightMenuType;
    
    [self.tableView reloadData];
}

@end
