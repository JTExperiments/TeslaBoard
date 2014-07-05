//
//  TBViewController.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBBeansBrowserViewController.h"
#import "TBBeansManager.h"

@interface TBBeansBrowserViewController ()

@end

@implementation TBBeansBrowserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[TBBeansManager sharedInstance] startScanning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [[TBBeansManager sharedInstance] stopScanning];
}

@end
