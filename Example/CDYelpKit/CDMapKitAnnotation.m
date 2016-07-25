//
//  MapKitAnnotation.m
//  Grocery Pal
//
//  Created by Christopher de Haan on 3/25/14.
//  Copyright (c) 2014 Meowing Rooster LLC. All rights reserved.
//

#import <AddressBook/AddressBook.h>

#import "CDMapKitAnnotation.h"

@implementation CDMapKitAnnotation

+ (CDMapKitAnnotation *)annotationFromYelpBusiness:(CDYelpBusiness *)business {
    
    CDMapKitAnnotation *annotation = [[CDMapKitAnnotation alloc] init];
    
    annotation.dataObject = business;
    annotation.title = business.name;
    NSMutableString *formattedAddress = [[NSMutableString alloc] initWithString:@""];
    for (NSString *addressComponent in business.location.display_address) {
        [formattedAddress appendFormat:@"%@ ", addressComponent];
    }
    annotation.subtitle = formattedAddress;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([business.location.latitude doubleValue], [business.location.longitude doubleValue]);
    annotation.coordinate = coordinate;
    NSMutableString *address = [[NSMutableString alloc] initWithString:@""];
    if (business.location.address.count > 0) {
        address = business.location.address[0];
    }
    annotation.address = @{(NSString *)kABPersonAddressStreetKey : address,
                           (NSString *)kABPersonAddressCityKey : business.location.city,
                           (NSString *)kABPersonAddressStateKey : business.location.state_code,
                           (NSString *)kABPersonAddressZIPKey : business.location.postal_code,
                           (NSString *)kABPersonAddressCountryKey : business.location.country_code};
    
    return annotation;
}

@end
