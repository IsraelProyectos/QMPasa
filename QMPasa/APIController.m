//
//  APIController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 26/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "APIController.h"
#import "Region.h"
#import "RegionPoint.h"

@implementation APIController

+ (void)importRegionDataFromDictionary:(NSDictionary*)dictionary {
    NSArray *regionsDict = [dictionary objectForKey:@"regions"];
    NSArray *pointsDict = [dictionary objectForKey:@"points"];
    
    for (NSDictionary *regionDict in regionsDict) {
        [Region createRegionWithDictionary:regionDict];
    }
    
    for (NSDictionary *pointDict in pointsDict) {
        [RegionPoint createRegionPointWithDictionary:pointDict];
    }
}

@end
