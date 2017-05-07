//
//  RegionPoint+CoreDataProperties.h
//  QMPasa
//
//  Created by Carles Frias Ferrer on 27/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RegionPoint.h"
#import "PointImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegionPoint (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *general;
@property (nullable, nonatomic, retain) NSString *pointId;
@property (nullable, nonatomic, retain) NSNumber *size;
@property (nullable, nonatomic, retain) NSNumber *superX;
@property (nullable, nonatomic, retain) NSNumber *superY;
@property (nullable, nonatomic, retain) NSNumber *x;
@property (nullable, nonatomic, retain) NSNumber *y;
@property (nullable, nonatomic, retain) Region *region;
@property (nullable, nonatomic, retain) NSSet<PointImage *> *images;

@end

@interface RegionPoint (CoreDataGeneratedAccessors)

- (void)addImagesObject:(PointImage *)value;
- (void)removeImagesObject:(PointImage *)value;
- (void)addImages:(NSSet<PointImage *> *)values;
- (void)removeImages:(NSSet<PointImage *> *)values;

@end

NS_ASSUME_NONNULL_END
