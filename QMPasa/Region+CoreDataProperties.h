//
//  Region+CoreDataProperties.h
//  QMPasa
//
//  Created by Carles Frias Ferrer on 27/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Region.h"

NS_ASSUME_NONNULL_BEGIN

@interface Region (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *regionId;
@property (nullable, nonatomic, retain) NSSet<RegionPoint *> *points;

@end

@interface Region (CoreDataGeneratedAccessors)

- (void)addPointsObject:(RegionPoint *)value;
- (void)removePointsObject:(RegionPoint *)value;
- (void)addPoints:(NSSet<RegionPoint *> *)values;
- (void)removePoints:(NSSet<RegionPoint *> *)values;

@end

NS_ASSUME_NONNULL_END
