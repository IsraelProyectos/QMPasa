//
//  Region.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 26/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "Region.h"
#import "RegionPoint.h"

@implementation Region

+ (Region*)createRegionWithDictionary:(NSDictionary*)dictionary {
    NSNumber *regionId = [dictionary objectForKey:@"id"];
    Region *region = [Region find:@{@"regionId": regionId}];
    
    if (!region) {
        region = [Region create];
        
        [region setRegionId:regionId];
    }
    
    NSString *name = [dictionary objectForKey:@"name"];
    
    if (name) {
        [region setName:name];
    }
    
    [region save];
    
    return region;
}

@end
