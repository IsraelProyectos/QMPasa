//
//  Region.h
//  QMPasa
//
//  Created by Carles Frias Ferrer on 26/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RegionPoint;

NS_ASSUME_NONNULL_BEGIN

@interface Region : NSManagedObject

+ (Region*)createRegionWithDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END

#import "Region+CoreDataProperties.h"
