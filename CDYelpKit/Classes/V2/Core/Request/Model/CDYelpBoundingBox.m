//
//  CDYelpBoundingBox.m
//  Pods
//
//  Created by Christopher de Haan on 7/9/16.
//
//

#import "CDYelpBoundingBox.h"

@implementation CDYelpBoundingBox

#pragma mark - Initialization Methods

+ (CDYelpBoundingBox *)boundingBoxFromSouthWestLocation:(CLLocation *)swLocation andNorthEastLocation:(CLLocation *)neLocation {
    
    CDYelpBoundingBox *boundingBox = [[CDYelpBoundingBox alloc] init];
    
    boundingBox.southWestCoordinate = swLocation.coordinate;
    boundingBox.northEastCoordinate = neLocation.coordinate;
    
    return boundingBox;
}

+ (CDYelpBoundingBox *)boundingBoxFromMapView:(MKMapView *)mapView {
    
    CDYelpBoundingBox *boundingBox = [[CDYelpBoundingBox alloc] init];
    
    NSArray *mapViewLocations = [self locationsArrayFromMapView:mapView];
    boundingBox.southWestCoordinate = ((CLLocation *)mapViewLocations[0]).coordinate;
    boundingBox.northEastCoordinate = ((CLLocation *)mapViewLocations[1]).coordinate;
    
    return boundingBox;
}

#pragma mark - Helper Methods

+ (NSArray *)locationsArrayFromMapView:(MKMapView *)mapView {
    // MapView's visible rect
    MKMapRect mapRect = mapView.visibleMapRect;
    // SW point for MapView
    MKMapPoint swMapPoint = MKMapPointMake(mapRect.origin.x, MKMapRectGetMaxY(mapRect));
    // NE point for MapView
    MKMapPoint neMapPoint = MKMapPointMake(MKMapRectGetMaxX(mapRect), mapRect.origin.y);
    // Convert points -> coordinates -> locations
    CLLocationCoordinate2D swCoord = MKCoordinateForMapPoint(swMapPoint);
    CLLocation *locationOne = [[CLLocation alloc] initWithLatitude:swCoord.latitude longitude:swCoord.longitude];
    CLLocationCoordinate2D neCoord = MKCoordinateForMapPoint(neMapPoint);
    CLLocation *locationTwo = [[CLLocation alloc] initWithLatitude:neCoord.latitude longitude:neCoord.longitude];
    // Create array with locations
    NSArray *locations = [[NSArray alloc] initWithObjects:locationOne, locationTwo, nil];
    
    return locations;
}

@end
