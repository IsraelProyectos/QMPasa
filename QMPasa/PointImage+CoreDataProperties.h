//
//  PointImage+CoreDataProperties.h
//  QMPasa
//
//  Created by Carles Frias Ferrer on 27/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PointImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface PointImage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) RegionPoint *regionPoint;

@end

NS_ASSUME_NONNULL_END
