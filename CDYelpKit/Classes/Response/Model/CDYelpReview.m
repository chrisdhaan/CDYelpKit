//
//  CDYelpReview.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpReview.h"

#import "CDYelpUser.h"

@implementation CDYelpReview

#pragma mark - Mantle Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"id": @"",
                               @"rating": [NSNumber numberWithInt:0],
                               @"rating_image_url": [NSURL URLWithString:@""],
                               @"rating_image_small_url": [NSURL URLWithString:@""],
                               @"rating_image_large_url": [NSURL URLWithString:@""],
                               @"excerpt": @"",
                               @"time_created": [NSDate new],
                               @"user": [CDYelpUser new]
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id": @"id",
             @"rating": @"rating",
             @"rating_image_url": @"rating_image_url",
             @"rating_image_small_url": @"rating_image_small_url",
             @"rating_image_large_url": @"rating_image_large_url",
             @"excerpt": @"excerpt",
             @"time_created": @"time_created",
             @"user": @"user"
             };
}

+ (NSValueTransformer *)rating_image_urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)rating_image_small_urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)rating_image_large_urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)userJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[CDYelpUser class]];
}

+ (NSValueTransformer *)time_createdJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^(NSNumber *dateNumber, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[dateNumber doubleValue]];
    } reverseBlock:^(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        NSTimeInterval timeInterval = [date timeIntervalSince1970];
        return [NSNumber numberWithDouble:timeInterval];
    }];
}

@end
