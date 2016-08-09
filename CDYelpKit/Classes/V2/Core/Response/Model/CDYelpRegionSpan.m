//
//  CDYelpRegionSpan.m
//  Pods
//
//  Created by Christopher de Haan on 8/8/16.
//
//

#import "CDYelpRegionSpan.h"

@implementation CDYelpRegionSpan

#pragma mark - Mantle Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"latitudeDelta": [NSNumber numberWithInt:0],
                               @"longitudeDelta": [NSNumber numberWithInt:0]
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"latitudeDelta": @"latitude_delta",
             @"longitudeDelta": @"longitude_delta"
             };
}

@end
