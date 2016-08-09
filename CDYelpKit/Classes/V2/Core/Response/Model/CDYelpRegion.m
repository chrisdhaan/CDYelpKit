//
//  CDYelpRegion.m
//  Pods
//
//  Created by Christopher de Haan on 8/8/16.
//
//

#import "CDYelpRegion.h"

#import "CDYelpRegionSpan.h"
#import "CDYelpRegionCenter.h"

@implementation CDYelpRegion

#pragma mark - Mantle Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"span": [CDYelpRegionSpan new],
                               @"center": [CDYelpRegionCenter new]
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"span": @"span",
             @"center": @"center"
             };
}

+ (NSValueTransformer *)spanJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[CDYelpRegionSpan class]];
}

+ (NSValueTransformer *)centerJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[CDYelpRegionCenter class]];
}

@end
