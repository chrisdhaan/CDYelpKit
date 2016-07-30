//
//  CDYelpGiftCertificate.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpGiftCertificate.h"

#import "CDYelpGiftCertificateOption.h"

@implementation CDYelpGiftCertificate

#pragma mark - Mantle Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"id": @"",
                               @"url": [NSURL URLWithString:@""],
                               @"image_url": [NSURL URLWithString:@""],
                               @"currency_code": @"",
                               @"unused_balances": @"",
                               @"options": @[]
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id": @"id",
             @"url": @"url",
             @"image_url": @"image_url",
             @"currency_code": @"currency_code",
             @"unused_balances": @"unused_balances",
             @"options": @"options"
             };
}

+ (NSValueTransformer *)urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)image_urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)optionsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CDYelpGiftCertificateOption class]];
}

@end
