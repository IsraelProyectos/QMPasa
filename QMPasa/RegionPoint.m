//
//  Point.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 26/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "RegionPoint.h"
#import "Region.h"

@implementation RegionPoint

+ (RegionPoint*)createRegionPointWithDictionary:(NSDictionary*)dictionary {
    NSString *pointId = [dictionary objectForKey:@"code"];
    RegionPoint *regionPoint = [RegionPoint find:@{@"pointId": pointId}];
    Region *region;
    
    if (!regionPoint) {
        regionPoint = [RegionPoint create];
        
        [regionPoint setPointId:pointId];
    }
    
    NSNumber *regionId = [dictionary objectForKey:@"regionId"];
    NSNumber *isGeneral = [dictionary objectForKey:@"isGeneral"];
    NSNumber *pointSize = [dictionary objectForKey:@"point_size"];
    NSNumber *x = [dictionary objectForKey:@"coordX"];
    NSNumber *y = [dictionary objectForKey:@"coordY"];
    NSNumber *detailX = [dictionary objectForKey:@"coordX_detail"];
    NSNumber *detailY = [dictionary objectForKey:@"coordY_detail"];
    
    if (regionId) {
        region = [Region find:@{@"regionId": regionId}];
        if (region) {
            [regionPoint setRegion:region];
        }
        else {
            NSLog(@"Region not found for point with ID: %@", pointId);
            return nil;
        }
    }
    
    if (isGeneral) {
        [regionPoint setGeneral:isGeneral];
    }
    
    if (pointSize) {
        [regionPoint setSize:pointSize];
    }
    
    if ([isGeneral boolValue]) {
        if (x) {
            [regionPoint setSuperX:x];
        }
        
        if (y) {
            [regionPoint setSuperY:y];
        }
    }
    
    if ([detailX isKindOfClass:[NSNumber class]]) {
        if (detailX) {
            [regionPoint setX:detailX];
        }
        
        if (detailY) {
            [regionPoint setY:detailY];
        }
    }
    
    [regionPoint save];
    
    [region addPointsObject:regionPoint];
    [region save];
    
    return regionPoint;
}

@end
