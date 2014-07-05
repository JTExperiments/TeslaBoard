//
//  TBAddVenueRequest.h
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;
@class TBVenue;

typedef void(^TBAddVenueCompletionHandler)(TBVenue *venue, NSError *error);

@interface TBAddVenueRequest : NSObject

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) TBAddVenueCompletionHandler completionBlock;

- (void)perform;

@end
