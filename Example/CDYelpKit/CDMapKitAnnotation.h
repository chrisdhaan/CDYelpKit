//
//  MapKitAnnotation.h
//  Grocery Pal
//
//  Created by Christopher de Haan on 3/25/14.
//  Copyright (c) 2014 Meowing Rooster LLC. All rights reserved.
//

#import <CDYelpKit/CDYelpKit-umbrella.h>
#import <MapKit/MapKit.h>

@interface CDMapKitAnnotation : NSObject <MKAnnotation> {
}

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSDictionary *address;

@property (strong, nonatomic) NSObject *dataObject;

+ (CDMapKitAnnotation *)annotationFromYelpBusiness:(CDYelpBusiness *)business;

@end
