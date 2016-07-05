//
//  CDYelpLocation.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Mantle/Mantle.h>

@interface CDYelpLocation : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSArray *address;
@property (copy, nonatomic, readonly) NSArray *display_address;
@property (copy, nonatomic, readonly) NSString *city;
@property (copy, nonatomic, readonly) NSString *state_code;
@property (copy, nonatomic, readonly) NSString *postal_code;
@property (copy, nonatomic, readonly) NSString *country_code;
@property (copy, nonatomic, readonly) NSString *cross_streets;
@property (copy, nonatomic, readonly) NSArray *neighborhoods;
@property (copy, nonatomic, readonly) NSNumber *latitude;
@property (copy, nonatomic, readonly) NSNumber *longitude;

@end
