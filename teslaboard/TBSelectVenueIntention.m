//
//  TBSelectVenueIntention.m
//  teslaboard
//
//  Created by James Tang on 6/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBSelectVenueIntention.h"
#import "TBVenueViewController.h"

@implementation TBSelectVenueIntention

- (void)perform {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TBVenueViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"venueViewController"];
    [self.viewController.navigationController pushViewController:controller
                                                        animated:YES];
}

@end
