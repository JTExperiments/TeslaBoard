//
//  TBVenue.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBVenue.h"
#import <AVOSCloud/AVOSCloud.h>
#import "TBClub.h"
@import MapKit;

@interface TBVenue ()

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *address;
@property (strong, nonatomic) MKCircle *circle;
@property (strong, nonatomic) TBClub *club;

@end


@implementation TBVenue

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@:%p> %@ {%f, %f} (club: %@)", self.class, self, self.name, self.coordinate.latitude, self.coordinate.longitude, self.club.name];
}

+ (TBVenue *)venueWithAVObject:(AVObject *)object {
    TBVenue *venue = [[TBVenue alloc] init];
    AVGeoPoint *point = [object objectForKey:@"location"];
    venue.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude);
    venue.name = [object objectForKey:@"name"];
    venue.address = [object objectForKey:@"address"];
    venue.circle = [MKCircle circleWithCenterCoordinate:venue.coordinate
                                                 radius:1 * 1000];
    venue.club = [TBClub clubWithAVObject:[object objectForKey:@"club"]];

    return venue;
}

#pragma mark MKAnnotation

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return [NSString stringWithFormat:@"地址：%@", self.address];
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
