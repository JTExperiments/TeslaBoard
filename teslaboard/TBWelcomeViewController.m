//
//  TBWelcomeViewController.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBWelcomeViewController.h"
#import "TBSelectBeanIntention.h"

@interface TBWelcomeViewController ()

@property (strong, nonatomic) IBOutlet TBSelectBeanIntention *selectBeanIntention;

@end

@implementation TBWelcomeViewController

- (IBAction)connectButtonDidPress:(id)sender {
    [self.selectBeanIntention perform];
}

@end
