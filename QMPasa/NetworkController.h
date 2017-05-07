//
//  NetworkController.h
//  QMPasa
//
//  Created by Carles Frias Ferrer on 26/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkController : NSObject

+ (void)updatePointsWithCompletion:(void(^)(NSError *error))completion;

@end
