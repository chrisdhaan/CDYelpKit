//
//  CDYelpError.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpError.h"

@implementation CDYelpError

#pragma mark - Mantle Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"text": @"",
                               @"id": @"",
                               @"field": @"",
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"text": @"text",
             @"id": @"id",
             @"field": @"field",
             };
}

@end
