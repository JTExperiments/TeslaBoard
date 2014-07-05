//
//  TBMapsViewController.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBMapsViewController.h"
@import MapKit;

@interface TBMapsViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKUserLocation *userLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation TBMapsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark MKMapViewDelegate

- (IBAction)moveToUserLocation:(id)sender {
    // Set location radius
    if([self userLocation]) {
        MKCoordinateSpan span = {.latitudeDelta =  0.03, .longitudeDelta =  0.03};
        MKCoordinateRegion region = {[self userLocation].location.coordinate, span};

        [self.mapView setRegion:region animated:YES];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    self.userLocation = userLocation;
    [self moveToUserLocation:nil];
}

@end
