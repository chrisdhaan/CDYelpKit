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

@end
