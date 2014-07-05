//
//  TBSelectBeanIntention.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBSelectBeanIntention.h"
#import "TBBeansBrowserViewController.h"

@interface TBSelectBeanIntention ()

@end

@implementation TBSelectBeanIntention

- (void)perform {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    TBBeansBrowserViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"beansBrowserViewController"];

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];

    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                                   style:UIBarButtonItemStylePlain
                                                                                  target:self action:@selector(cancelButtonDidPress:)];

    [self.viewController presentViewController:navController
                                      animated:YES completion:NULL];
}

- (void)cancelButtonDidPress:(id)sender {
    [self.viewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
