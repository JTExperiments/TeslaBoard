//
//  TBMapsViewController.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBMapsViewController.h"
#import "TBAddVenueRequest.h"
@import MapKit;

@interface TBMapsViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKUserLocation *userLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) TBAddVenueRequest *addVenueRequest;

@end

@implementation TBMapsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)listButtonDidPress:(id)sender {

    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)addButtonDidPress:(id)sender {
    CLLocationCoordinate2D coordinate = self.mapView.centerCoordinate;

    NSLog(@"coordinate %f %f", coordinate.latitude, coordinate.longitude);

    self.addVenueRequest = [[TBAddVenueRequest alloc] init];
    self.addVenueRequest.name = @"Test";
    self.addVenueRequest.coordinate = coordinate;
    self.addVenueRequest.completionBlock = ^(TBVenue *venue, NSError *error) {
        NSLog(@"%@", venue);
    };
    [self.addVenueRequest perform];
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
