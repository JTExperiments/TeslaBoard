//
//  TBVenue.h
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVObject;

@import CoreLocation;

@interface TBVenue : NSObject

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic, readonly) NSString *name;

+ (TBVenue *)venueWithAVObject:(AVObject *)object;

@end
