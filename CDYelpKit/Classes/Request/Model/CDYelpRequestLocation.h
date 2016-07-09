//
//  CDYelpQueryLocation.h
//  Pods
//
//  Created by Christopher de Haan on 7/8/16.
//
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

#import "CDYelpRequestLocationType.h"

@class CDYelpBoundingBox;

@interface CDYelpRequestLocation : NSObject

@property (nonatomic, readwrite) CDYelpRequestLocationType requestLocationType;
@property (nonatomic, readwrite) CLLocationCoordinate2D currentLocationCoordinate;
@property (copy, nonatomic, readwrite) CDYelpBoundingBox *boundingBox;

+ (CDYelpRequestLocation *)requestLocationFromBoundingBox:(CDYelpBoundingBox *)boundingBox;
+ (CDYelpRequestLocation *)requestLocationFromCurrentCurrentLocation:(CLLocation *)currentLocation;

@end
