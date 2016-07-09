//
//  CDYelpUser.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpUser.h"

@implementation CDYelpUser

#pragma mark - Mantle Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"id": @"",
                               @"image_url": [NSURL URLWithString:@""],
                               @"name": @""
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id": @"id",
             @"image_url": @"image_url",
             @"name": @"name"
             };
}

+ (NSValueTransformer *)image_urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
