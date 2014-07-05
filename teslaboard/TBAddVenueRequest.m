//
//  TBAddVenueRequest.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBAddVenueRequest.h"
#import <AVOSCloud/AVOSCloud.h>
#import "TBVenue.h"

@implementation TBAddVenueRequest

- (void)perform {
    __weak typeof(self)weakSelf = self;;
    AVObject *object = [AVObject objectWithClassName:@"Venue"];
    AVGeoPoint * point = [AVGeoPoint geoPointWithLatitude:self.coordinate.latitude
                                                longitude:self.coordinate.longitude];
    [object setObject:point forKey:@"location"];
    [object setObject:self.name forKey:@"name"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

        TBVenue *venue;
        if (succeeded) {
            venue = [TBVenue venueWithAVObject:object];
        }

        if (weakSelf.completionBlock) {
            weakSelf.completionBlock(venue, error);
        }
    }];
}

@end
