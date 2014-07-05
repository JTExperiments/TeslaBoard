//
//  TBViewController.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBBeansBrowserViewController.h"
#import "TBBeansDataSource.h"

@interface TBBeansBrowserViewController () <TBBeansDataSourceDelegate>

@end

@implementation TBBeansBrowserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark Action

- (void)beansDataSource:(TBBeansDataSource *)dataSource didSelectBean:(PTDBean *)bean {

    NSLog(@"bean %@", bean);
}

@end
