//
//  TBSelectVenueIntention.h
//  teslaboard
//
//  Created by James Tang on 6/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBVenue;

@interface TBSelectVenueIntention : NSObject

@property (weak, nonatomic) IBOutlet UIViewController *viewController;
@property (strong, nonatomic) TBVenue *venue;

- (void)perform;

@end
