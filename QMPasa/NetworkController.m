//
//  NetworkController.m
//  QMPasa
//
//  Created by Carles Frias Ferrer on 26/07/16.
//  Copyright © 2016 Carles Frias Ferrer. All rights reserved.
//

#import "NetworkController.h"
#import <AFNetworking.h>
#import "APIController.h"

@implementation NetworkController

+ (void)updatePointsWithCompletion:(void(^)(NSError *error))completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://setfile.eu/QMPasa/controller/getPoints.php" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [APIController importRegionDataFromDictionary:responseObject];
        
        completion(nil);
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(error);
    }];
}

@end
