//
//  CDYelpGiftCertificateOption.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpGiftCertificateOption.h"

@implementation CDYelpGiftCertificateOption

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"price": [NSNumber numberWithInt:0],
                               @"formatted_price": @""
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"price": @"price",
             @"formatted_price": @"formatted_price"
             };
}

@end
