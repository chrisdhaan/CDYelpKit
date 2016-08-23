//
//  CDYelpBoundingBox.m
//  Pods
//
//  Created by Christopher de Haan on 7/9/16.
//
//  Copyright (c) 2016 Christopher de Haan <contact@christopherdehaan.me>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
