//
//  TBVenue.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBVenue.h"
#import <AVOSCloud/AVOSCloud.h>
@import MapKit;

@interface TBVenue ()

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) MKCircle *circle;

@end


@implementation TBVenue

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@:%p> %@ {%f, %f}", self.class, self, self.name, self.coordinate.latitude, self.coordinate.longitude];
}

+ (TBVenue *)venueWithAVObject:(AVObject *)object {
    TBVenue *venue = [[TBVenue alloc] init];
    AVGeoPoint *point = [object objectForKey:@"location"];
    venue.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude);
    venue.name = [object objectForKey:@"name"];

    venue.circle = [MKCircle circleWithCenterCoordinate:venue.coordinate
                                                 radius:1 * 1000];

    return venue;
}

#pragma mark MKAnnotation

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return [NSString stringWithFormat:@"%f, %f", self.coordinate.latitude, self.coordinate.longitude];
}

#pragma mark MKOverlay

- (MKMapRect)boundingMapRect {
    return self.circle.boundingMapRect;
}

- (BOOL)intersectsMapRect:(MKMapRect)mapRect {
    return [self.circle intersectsMapRect:mapRect];
}

- (CLLocationDistance)radius {
    return self.circle.radius;
}

@end
