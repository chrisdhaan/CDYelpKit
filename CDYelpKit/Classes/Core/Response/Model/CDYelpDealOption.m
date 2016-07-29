//
//  CDYelpDealOption.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpDealOption.h"

@implementation CDYelpDealOption

#pragma mark - Mantle Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"title": @"",
                               @"purchase_url": [NSURL URLWithString:@""],
                               @"price": [NSNumber numberWithInt:0],
                               @"formatted_price": @"",
                               @"original_price": [NSNumber numberWithInt:0],
                               @"formatted_original_price": @"",
                               @"is_quantity_limited": @NO,
                               @"remaining_count": [NSNumber numberWithInt:0]
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title": @"title",
             @"purchase_url": @"purchase_url",
             @"price": @"price",
             @"formatted_price": @"formatted_price",
             @"original_price": @"original_price",
             @"formatted_original_price": @"formatted_original_price",
             @"is_quantity_limited": @"is_quantity_limited",
             @"remaining_count": @"remaining_count"
             };
}

+ (NSValueTransformer *)purchase_urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
