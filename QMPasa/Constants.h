//
//  Constants.h
//  QMPasa
//
//  Created by Carles Frias Ferrer on 13/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPointHeadX 10
#define kPointHeadY 450
#define kPointToraxX 20
#define kPointToraxY 150
#define kPointAbdomenX 0
#define kPointAbdomenY 20
#define kPointGenitalsX -14
#define kPointGenitalsY -114
#define kPointLegX -50
#define kPointLegY -250
#define kPointFootX -50
#define kPointFootY -475

#define kPointHeadBehindX 10
#define kPointHeadBehindY 450
#define kPointChestBehindX 20
#define kPointChestBehindY 150
#define kPointAbdomenBehindY 20
#define kPointGenitalsBehindX 14
#define kPointGenitalsBehindY 114
#define kPointKneesBehindX 50
#define kPointKneesBehindY 250
#define kPointFeetBehindX 50
#define kPointFeetBehindY 475

typedef NS_ENUM (NSUInteger, EssentialControllerType) {
    EssentialControllerTypeGender = 0,
    EssentialControllerTypeAge,
    EssentialControllerTypeHenry,
    EssentialControllerTypeCount
};

typedef NS_ENUM (NSUInteger, RegionType) {
    RegionTypeHead = 1,
    RegionTypeFace,
    RegionTypeNeck,
    RegionTypeBack,
    RegionTypeTorax,
    RegionTypeArm,
    RegionTypeHand,
    RegionTypeAbdomen,
    RegionTypeHip,
    RegionTypeAss,
    RegionTypeGenitals,
    RegionTypeLeg,
    RegionTypeFoot
};

@interface Constants : NSObject

@end
