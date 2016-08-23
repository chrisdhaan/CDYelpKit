//
//  CDYelpQueryParams.h
//  Pods
//
//  Created by Christopher de Haan on 7/8/16.
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

#import <Foundation/Foundation.h>

#import "CDYelpSortType.h"

@class CDYelpRequestLocation;

@interface CDYelpQueryParams : NSObject

@property (copy, nonatomic, readwrite) NSDictionary *paramsDict;

+ (CDYelpQueryParams *)businessEndpointQueryParamsWithCoutryCode:(NSString *)countryCode
                                                withLanguageCode:(NSString *)languageCode
                                              withLangaugeFilter:(BOOL)languageFilter
                                                 withActionLinks:(BOOL)actionLinks;

+ (CDYelpQueryParams *)searchEndpointQueryParamsWithSearchTerm:(NSString *)searchTerm
                                                     withLimit:(NSInteger)limit
                                                    withOffset:(NSInteger)offset
                                                  withSortType:(CDYelpSortType)sortType
                                                withCategories:(NSArray *)categories
                                              withRadiusFilter:(NSInteger)radiusFilter
                                               withDealsFilter:(BOOL)dealsFilter
                                           withRequestLocation:(CDYelpRequestLocation *)requestLocation;

+ (CDYelpQueryParams *)phoneSearchEndpointQueryParamsWithPhoneNumber:(NSString *)phoneNumber
                                                     withCountryCode:(NSString *)countryCode
                                                      withCategories:(NSArray *)categories;

@end
