//
//  TBMapsViewController.m
//  teslaboard
//
//  Created by James Tang on 5/7/14.
//  Copyright (c) 2014 TeslaBoard. All rights reserved.
//

#import "TBMapsViewController.h"
#import "TBAddVenueIntention.h"
#import "TBGetVenuesRequest.h"
#import "TBVenue.h"

@import MapKit;

@interface TBMapsViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKUserLocation *userLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) TBAddVenueIntention *addVenueIntention;
@property (strong, nonatomic) TBGetVenuesRequest *getVenuesRequet;
@property (copy, nonatomic) NSArray *venues;  // TBVenue

@end

@implementation TBMapsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    __weak typeof(self)weakSelf = self;
    self.getVenuesRequet = [[TBGetVenuesRequest alloc] init];
    self.getVenuesRequet.completion = ^(NSArray *venues, NSError *error) {
        weakSelf.venues = venues;
        NSLog(@"venues %@", venues);
    };
    [self.getVenuesRequet perform];
}

- (IBAction)listButtonDidPress:(id)sender {

    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)addButtonDidPress:(id)sender {
    CLLocationCoordinate2D coordinate = self.mapView.centerCoordinate;

    NSLog(@"coordinate %f %f", coordinate.latitude, coordinate.longitude);

    self.addVenueIntention = [[TBAddVenueIntention alloc] init];
    self.addVenueIntention.coordinate = coordinate;
    [self.addVenueIntention perform];
}

#pragma mark Overrides

- (void)setVenues:(NSArray *)venues {
    _venues = [venues copy];
    [self.mapView addAnnotations:_venues];
    [self.mapView addOverlays:_venues];
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

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {

    MKCircleRenderer *renderrer = [[MKCircleRenderer alloc] initWithCircle:overlay];
    renderrer.fillColor = [UIColor colorWithRed:(CGFloat)0x34/0xff
                                          green:(CGFloat)0xa3/0xff
                                           blue:(CGFloat)0xdb/0xff
                                          alpha:0.2];

    return renderrer;
}

@end
