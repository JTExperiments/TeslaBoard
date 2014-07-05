//
//  TBGetVenuesRequest.h
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

typedef void(^TBGetVenuesCompletionHandler)(NSArray *venues, NSError *error); // TBVenue

@interface TBGetVenuesRequest : NSObject

@property (copy, nonatomic) TBGetVenuesCompletionHandler completion;

- (void)perform;

@end
