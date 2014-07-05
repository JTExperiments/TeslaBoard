//
//  TBGetVenuesRequest.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBGetVenuesRequest.h"
#import <AVOSCloud/AVOSCloud.h>
#import "TBVenue.h"

@implementation TBGetVenuesRequest

- (void)perform {
    __weak typeof(self)weakSelf = self;

    AVQuery * query = [AVQuery queryWithClassName:@"Venue"];
    query.limit = 100;
    [query includeKey:@"club"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        NSMutableArray *venues = [[NSMutableArray alloc] init];

        [objects enumerateObjectsUsingBlock:^(AVObject *obj, NSUInteger idx, BOOL *stop) {

            TBVenue *venue = [TBVenue venueWithAVObject:obj];
            [venues addObject:venue];
        }];

        if (weakSelf.completion) {
            weakSelf.completion(venues, error);
        }
    }];

}

@end
