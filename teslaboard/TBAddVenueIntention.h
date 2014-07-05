//
//  TBAddVenueIntention.h
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

@import CoreLocation;

@interface TBAddVenueIntention : NSObject

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (weak, nonatomic) IBOutlet UIViewController *viewController;

- (void)perform;

@end
