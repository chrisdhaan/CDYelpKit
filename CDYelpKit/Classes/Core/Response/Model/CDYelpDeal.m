//
//  CDYelpDeal.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//  Copyright (c) 2016 Christopher de Haan <contact@christopherdehaan.me>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
