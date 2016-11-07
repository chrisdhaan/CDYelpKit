//
//  CDYelpReview.m
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
