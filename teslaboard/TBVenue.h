//
//  TBVenue.h
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;
@class AVObject;
@class TBClub;

@import CoreLocation;

@interface TBVenue : NSObject <MKAnnotation, MKOverlay>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic, readonly) NSString *name;
@property (copy, nonatomic, readonly) NSString *address;
@property (strong, nonatomic, readonly) TBClub *club;

+ (TBVenue *)venueWithAVObject:(AVObject *)object;

@end
