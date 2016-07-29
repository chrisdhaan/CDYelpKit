//
//  CDYelpDeal.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpDeal.h"

#import "CDYelpDealOption.h"

@implementation CDYelpDeal

#pragma mark - Mantle Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"id": @"",
                               @"title": @"",
                               @"url": [NSURL URLWithString:@""],
                               @"image_url": [NSURL URLWithString:@""],
                               @"currency_code": @"",
                               @"time_start": [NSDate new],
                               @"time_end": [NSDate new],
                               @"is_popular": @NO,
                               @"what_you_get": @"",
                               @"important_restrictions": @"",
                               @"additional_restrictions": @"",
                               @"options": @[]
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id": @"id",
             @"title": @"title",
             @"url": @"url",
             @"image_url": @"image_url",
             @"currency_code": @"currency_code",
             @"time_start": @"time_start",
             @"time_end": @"time_end",
             @"is_popular": @"is_popular",
             @"what_you_get": @"what_you_get",
             @"important_restrictions": @"important_restrictions",
             @"additional_restrictions": @"additional_restrictions",
             @"options": @"options"
             };
}

+ (NSValueTransformer *)urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)image_urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)time_startJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^(NSNumber *dateNumber, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[dateNumber doubleValue]];
    } reverseBlock:^(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        NSTimeInterval timeInterval = [date timeIntervalSince1970];
        return [NSNumber numberWithDouble:timeInterval];
    }];
}

+ (NSValueTransformer *)time_endJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^(NSNumber *dateNumber, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[dateNumber doubleValue]];
    } reverseBlock:^(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        NSTimeInterval timeInterval = [date timeIntervalSince1970];
        return [NSNumber numberWithDouble:timeInterval];
    }];
}

+ (NSValueTransformer *)optionsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CDYelpDealOption class]];
}

@end
