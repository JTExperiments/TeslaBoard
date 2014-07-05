//
//  TBVenue.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBVenue.h"
#import <AVOSCloud/AVOSCloud.h>

@interface TBVenue ()

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *name;

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
    return venue;
}

#pragma mark MKAnnotation

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return [NSString stringWithFormat:@"%f, %f", self.coordinate.latitude, self.coordinate.longitude];
}

@end
