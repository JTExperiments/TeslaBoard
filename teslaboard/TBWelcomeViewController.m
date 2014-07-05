//
//  TBWelcomeViewController.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBWelcomeViewController.h"
#import "TBSelectBeanIntention.h"
#import "TBBeansManager.h"
#import "PTDBean.h"

@interface TBWelcomeViewController ()

@property (strong, nonatomic) IBOutlet TBSelectBeanIntention *selectBeanIntention;

@end

@implementation TBWelcomeViewController

- (IBAction)connectButtonDidPress:(id)sender {
    [self.selectBeanIntention perform];
}

- (IBAction)sendButtonDidPress:(id)sender {
    NSLog(@"!");

    // set the scratch bank, 1-5
    int scratchNumber = 1;

    // set the scratch data
    PTDBean *bean = [TBBeansManager sharedInstance].bean;

    [bean setScratchNumber:scratchNumber withValue:[@"scratchdata" dataUsingEncoding:NSUTF8StringEncoding]];
    // after some time, ask for it back
    [bean readScratchBank:scratchNumber];

}

@end
