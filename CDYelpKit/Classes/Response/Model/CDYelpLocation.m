//
//  CDYelpLocation.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpLocation.h"

@implementation CDYelpLocation

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"address": @[@""],
                               @"display_address": @[@""],
                               @"city": @"",
                               @"state_code": @"",
                               @"postal_code": @"",
                               @"country_code": @"",
                               @"cross_streets": @"",
                               @"neighborhoods": @[@""],
                               @"latitude": [NSNumber numberWithInt:0],
                               @"longitude": [NSNumber numberWithInt:0]
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"address": @"address",
             @"display_address": @"display_address",
             @"city": @"city",
             @"state_code": @"state_code",
             @"postal_code": @"postal_code",
             @"country_code": @"country_code",
             @"cross_streets": @"cross_streets",
             @"neighborhoods": @"neighborhoods",
             @"latitude": @"coordinate.latitude",
             @"longitude": @"coordinate.longitude"
             };
}

@end
