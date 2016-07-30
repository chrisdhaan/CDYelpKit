//
//  CDYelpQueryLocation.m
//  Pods
//
//  Created by Christopher de Haan on 7/8/16.
//
//

#import "CDYelpRequestLocation.h"

@implementation CDYelpRequestLocation

#pragma mark - Initialization Methods

+ (CDYelpRequestLocation *)requestLocationFromBoundingBox:(CDYelpBoundingBox *)boundingBox {
    
    CDYelpRequestLocation *requestLocation = [[CDYelpRequestLocation alloc] init];
    
    requestLocation.requestLocationType = kCDYelpRequestLocationTypeBoundingBox;
    requestLocation.boundingBox = boundingBox;
    
    return requestLocation;
}

+ (CDYelpRequestLocation *)requestLocationFromCurrentCurrentLocation:(CLLocation *)currentLocation {
    
    CDYelpRequestLocation *requestLocation = [[CDYelpRequestLocation alloc] init];
    
    requestLocation.requestLocationType = kCDYelpRequestLocationTypeCurrentLocation;
    requestLocation.currentLocationCoordinate = currentLocation.coordinate;
    
    return requestLocation;
}

@end
