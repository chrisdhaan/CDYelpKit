//
//  CDViewController.m
//  CDYelpKit
//
//  Created by Christopher de Haan on 06/29/2016.
//  Copyright (c) 2016 Christopher de Haan. All rights reserved.
//

#import <CDYelpKit/CDYelpKit-umbrella.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "CDViewController.h"
#import "CDMapKitAnnotation.h"

static NSString *defaultAnnotationID = @"CDMapKitAnnotation";

@interface CDViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *locationSegmentedControl;
@property (nonatomic, weak) IBOutlet UITextField *searchTermTextField;
@property (nonatomic, weak) IBOutlet UITextField *limitTextField;
@property (nonatomic, weak) IBOutlet UITextField *offsetTextField;
@property (nonatomic, weak) IBOutlet UISegmentedControl *sortTypeSegmentedControl;
@property (nonatomic, weak) IBOutlet UIButton *categoriesButton;
@property (nonatomic, weak) IBOutlet UITextField *radiusTextField;
@property (nonatomic, weak) IBOutlet UISwitch *dealsSwitch;
@property (nonatomic, weak) IBOutlet UIButton *searchYelpButton;

@end

@implementation CDViewController {
    CDYelpKitManager *yelpKitManager;
    
    CLLocationManager *locationManager;
    
    NSMutableArray *mapAnnotations;
}

#pragma mark - Initialization Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Configure MapView
    [self.mapView setDelegate:self];
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    
    // Configure LocationManager
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    // Configure CDYelpKit
    yelpKitManager = [[CDYelpKitManager alloc] initWithConsumerKey:@"tPaCOcHvMIo_aIDL4jFqPw"
                                      consumerSecret:@"W_q1ACetRjYbxnawi7F2R3VPXyc"
                                               token:@"9L_Mjmot-lNHcF4UNfxn7M60OwKEAjVH"
                                         tokenSecret:@"J-lVxUaPiAq2qOiRWJ-o4Yck0oY"];
    
    mapAnnotations = [[NSMutableArray alloc] init];
    [self resetMapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - CLLocationManager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *location = [locations lastObject];
    
    [locationManager stopUpdatingLocation];
    
    [self.mapView setShowsUserLocation:YES];
    
    // Center mapView on users location
    MKCoordinateRegion region = { {0.0, 0.0}, {0.0, 0.0} };
    region.center.latitude = location.coordinate.latitude;
    region.center.longitude = location.coordinate.longitude;
    region.span.latitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - MKMapView Delegate Methods

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    // User location pin is not selectable
    if ([view.annotation isKindOfClass:[MKUserLocation class]])
        return;
    
    CDMapKitAnnotation *annotation = view.annotation;
    
    // Center map on pin
    [mapView setCenterCoordinate:annotation.coordinate animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKPinAnnotationView *pinView = nil;
    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultAnnotationID];
    
    if (pinView == nil) {
        
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultAnnotationID];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
    }
    return pinView;
}

#pragma mark - Button Methods

- (IBAction)locationSegmentedControlPressed:(UISegmentedControl *)sender {
    MKCoordinateRegion region = { {0.0, 0.0}, {0.0, 0.0} };
    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
    
    if (sender.selectedSegmentIndex == 0) {
        // Center mapView on users location
        region.span.latitudeDelta = 0.005f;
        region.span.longitudeDelta = 0.005f;
    } else {
        // Zoom out to see mapView region
        region.span.latitudeDelta = 0.015f;
        region.span.longitudeDelta = 0.015f;
    }
    
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)categoriesButtonPressed:(UIButton *)sender {
}

- (IBAction)searchYelpButtonPressed:(UIButton *)sender {
    NSString *searchTerm = self.searchTermTextField.text;
    NSInteger limit = [self.limitTextField.text integerValue];
    NSInteger offset = [self.offsetTextField.text integerValue];
    CDYelpSortType sortType = self.sortTypeSegmentedControl.selectedSegmentIndex;
    NSArray *categories = @[];
    NSInteger radius = [self.radiusTextField.text integerValue];
    BOOL hasDeals = self.dealsSwitch.on;
    CDYelpRequestLocation *requestLocation;
    if (self.locationSegmentedControl.selectedSegmentIndex == 0) {
        requestLocation = [CDYelpRequestLocation requestLocationFromCurrentCurrentLocation:self.mapView.userLocation.location];
    } else {
        // Example generating bounding box with MKMapView
        CDYelpBoundingBox *boundingBox = [CDYelpBoundingBox boundingBoxFromMapView:self.mapView];
        // Example generating bounding box with array of locations
//        NSArray *mapViewBoundingBoxLocations = [CDYelpBoundingBox locationsArrayFromMapView:self.mapView];
//        CDYelpBoundingBox *boundingBox = [CDYelpBoundingBox boundingBoxFromSouthWestLocation:mapViewBoundingBoxLocations[0] andNorthEastLocation:mapViewBoundingBoxLocations[1]];
        requestLocation = [CDYelpRequestLocation requestLocationFromBoundingBox:boundingBox];
    }
        
    // Query Yelp API for business results
    [yelpKitManager searchYelpBusinessesWithSearchTerm:searchTerm
                                             withLimit:limit
                                            withOffset:offset
                                          withSortType:sortType
                                        withCategories:categories
                                      withRadiusFilter:radius
                                withDealsFilter:hasDeals
                                   withRequestLocation:requestLocation
                                       completionBlock:^(BOOL successful, NSError * _Nullable error, NSMutableArray * _Nullable results) {
                                
                                if (successful && results && results.count > 0) {
                                    
                                    [self populateMapWithYelpResults:results];
                                }
                            }];
}

#pragma mark - Private Methods

- (void)populateMapWithYelpResults:(NSArray *)results {
    
    // Clear mapView if previously populated
    [self resetMapView];
    
    for (CDYelpBusiness *business in results) {
        
        // Drop new pin
        CDMapKitAnnotation *annotation = [CDMapKitAnnotation annotationFromYelpBusiness:business];
        [self.mapView addAnnotation:annotation];
        
        [mapAnnotations addObject:annotation];
    }
    
    // Center mapView on first returned business
    CDYelpBusiness *firstBusiness = results.firstObject;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([firstBusiness.location.latitude doubleValue], [firstBusiness.location.longitude doubleValue]) animated:true];
}

- (void)resetMapView {
    
    id userLocation = [self.mapView userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[self.mapView annotations]];
    if (userLocation != nil) {
        // Avoid removing user location off the map
        [pins removeObject:userLocation];
    }
    
    [self.mapView removeAnnotations:pins];
    
    [mapAnnotations removeAllObjects];
}

@end
