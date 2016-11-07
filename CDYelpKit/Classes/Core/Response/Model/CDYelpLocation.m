//
//  CDYelpLocation.m
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

#import "CDYelpLocation.h"

@implementation CDYelpLocation

#pragma mark - Mantle Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"address": @[@""],
                               @"display_address": @[@""],
                               @"city": @"",
                               @"state_code": @"",
                               @"postal_code": @"",
                               @"country_code": @"",
                               @"cross_streets": @"",
                               @"neighborhoods": @[@""],
                               @"latitude": [NSNumber numberWithInt:0],
                               @"longitude": [NSNumber numberWithInt:0]
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"address": @"address",
             @"display_address": @"display_address",
             @"city": @"city",
             @"state_code": @"state_code",
             @"postal_code": @"postal_code",
             @"country_code": @"country_code",
             @"cross_streets": @"cross_streets",
             @"neighborhoods": @"neighborhoods",
             @"latitude": @"coordinate.latitude",
             @"longitude": @"coordinate.longitude"
             };
}

@end
