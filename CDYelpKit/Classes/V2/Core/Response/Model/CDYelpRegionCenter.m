//
//  CDYelpRegionCenter.m
//  Pods
//
//  Created by Christopher de Haan on 8/8/16.
//
//

#import "CDYelpRegionCenter.h"

@implementation CDYelpRegionCenter

#pragma mark - Mantle Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"latitude": [NSNumber numberWithInt:0],
                               @"longitude": [NSNumber numberWithInt:0]
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"latitude": @"latitude",
             @"longitude": @"longitude"
             };
}

@end
