//
//  Point.h
//  QMPasa
//
//  Created by Carles Frias Ferrer on 26/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <ObjectiveRecord.h>

@class Region;

NS_ASSUME_NONNULL_BEGIN

@interface RegionPoint : NSManagedObject

+ (RegionPoint*)createRegionPointWithDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END

#import "RegionPoint+CoreDataProperties.h"
