//
//  CDYelpBoundingBox.h
//  Pods
//
//  Created by Christopher de Haan on 7/9/16.
//
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CDYelpBoundingBox : NSObject

@property (nonatomic, readwrite) CLLocationCoordinate2D southWestCoordinate;
@property (nonatomic, readwrite) CLLocationCoordinate2D northEastCoordinate;

+ (CDYelpBoundingBox *)boundingBoxFromSouthWestLocation:(CLLocation *)swLocation andNorthEastLocation:(CLLocation *)neLocation;
+ (CDYelpBoundingBox *)boundingBoxFromMapView:(MKMapView *)mapView;

+ (NSArray *)locationsArrayFromMapView:(MKMapView *)mapView;

@end