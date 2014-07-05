//
//  TBAddVenueIntention.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBAddVenueIntention.h"
#import "TBAddVenueRequest.h"

@interface TBAddVenueIntention () <UIAlertViewDelegate>

@property (strong, nonatomic) TBAddVenueRequest *addVenueRequest;

@end


@implementation TBAddVenueIntention

- (void)perform {
    NSString *message = [NSString stringWithFormat:@"%f %f", _coordinate.latitude, _coordinate.longitude];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"加入地點"
                                                        message:message
                                                       delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"確地", nil];


    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

    [alertView textFieldAtIndex:0].placeholder = @"地點";

    [alertView show];
}


#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
    }

    self.addVenueRequest = [[TBAddVenueRequest alloc] init];
    self.addVenueRequest.name = [alertView textFieldAtIndex:0].text;
    self.addVenueRequest.coordinate = _coordinate;
    self.addVenueRequest.completionBlock = ^(TBVenue *venue, NSError *error) {
        NSLog(@"%@", venue);
    };
    [self.addVenueRequest perform];
}

@end
