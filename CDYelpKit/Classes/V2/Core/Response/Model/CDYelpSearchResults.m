//
//  CDYelpSearchResults.m
//  Pods
//
//  Created by Christopher de Haan on 8/8/16.
//
//

#import "CDYelpSearchResults.h"

#import "CDYelpRegion.h"
#import "CDYelpBusiness.h"

@implementation CDYelpSearchResults

#pragma mark - Mantle Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"region": [CDYelpRegion new],
                               @"total": [NSNumber numberWithInt:0],
                               @"businesses": @[]
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"region": @"region",
             @"total": @"total",
             @"businesses": @"businesses"
             };
}

+ (NSValueTransformer *)regionJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[CDYelpRegion class]];
}

+ (NSValueTransformer *)businessesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CDYelpBusiness class]];
}

@end
