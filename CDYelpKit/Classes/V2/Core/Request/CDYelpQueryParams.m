//
//  CDYelpQueryParams.m
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

#import "CDYelpQueryParams.h"

#import "CDYelpModels.h"

@implementation CDYelpQueryParams

#pragma mark - Initialization Methods

+ (CDYelpQueryParams *)businessEndpointQueryParamsWithCoutryCode:(NSString *)countryCode
                                                withLanguageCode:(NSString *)languageCode
                                              withLangaugeFilter:(BOOL)languageFilter
                                                 withActionLinks:(BOOL)actionLinks {
    
    CDYelpQueryParams *queryParams = [[CDYelpQueryParams alloc] init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (countryCode != nil && ![countryCode isEqualToString:@""]) {
        dict[@"cc"] = countryCode;
    }
    
    if (languageCode != nil && ![languageCode isEqualToString:@""]) {
        dict[@"lang"] = languageCode;
    }
    
    if (languageFilter == true) {
        dict[@"lang_filter"] = @"1";
    }
    
    if (actionLinks == true) {
        dict[@"actionlinks"] = @"1";
    }
    
    NSDictionary *objectDict = [[NSDictionary alloc] initWithDictionary:dict];
    queryParams.paramsDict = objectDict;
    
    return queryParams;
}

+ (CDYelpQueryParams *)searchEndpointQueryParamsWithSearchTerm:(NSString *)searchTerm
                                                     withLimit:(NSInteger)limit
                                                    withOffset:(NSInteger)offset
                                                  withSortType:(CDYelpSortType)sortType
                                                withCategories:(NSArray *)categories
                                              withRadiusFilter:(NSInteger)radiusFilter
                                               withDealsFilter:(BOOL)dealsFilter
                                           withRequestLocation:(CDYelpRequestLocation *)requestLocation {
    
    CDYelpQueryParams *queryParams = [[CDYelpQueryParams alloc] init];
    
    NSString *finalCategoriesString = @"";
    
    if (categories != nil) {
        if (categories.count > 0) {
            NSMutableString *categoriesString = [[NSMutableString alloc] initWithString:@""];
            for (NSString *yelpCategoryID in categories) {
                [categoriesString appendFormat:@"%@,", yelpCategoryID];
            }
            
            finalCategoriesString = [categoriesString substringToIndex:[categoriesString length] - 1];
        }
    }
    
    NSString *locationKey = @"";
    NSString *locationValue = @"";
    
    if (requestLocation != nil) {
        switch (requestLocation.requestLocationType) {
            case kCDYelpRequestLocationTypeCurrentLocation:
                locationKey = @"ll";
                locationValue = [NSString stringWithFormat:@"%f,%f", requestLocation.currentLocationCoordinate.latitude, requestLocation.currentLocationCoordinate.longitude];
                break;
            case kCDYelpRequestLocationTypeBoundingBox:
                locationKey = @"bounds";
                locationValue = [NSString stringWithFormat:@"%f,%f|%f,%f", requestLocation.boundingBox.southWestCoordinate.latitude, requestLocation.boundingBox.southWestCoordinate.longitude, requestLocation.boundingBox.northEastCoordinate.latitude, requestLocation.boundingBox.northEastCoordinate.longitude];
                break;
            default:
                break;
        }
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (searchTerm != nil && ![searchTerm isEqualToString:@""]) {
        dict[@"term"] = [NSString stringWithFormat:@"%@", searchTerm];
    }
    
    if (limit > 0) {
        dict[@"limit"] = [NSString stringWithFormat:@"%ld", (long)limit];
    }
    
    if (offset > 0) {
        dict[@"offset"] = [NSString stringWithFormat:@"%ld", (long)offset];
    }
    
    if (sortType != kCDYelpSortTypeNone) {
        dict[@"sort"] = [NSString stringWithFormat:@"%ld", (long)sortType];
    }
    
    if (![finalCategoriesString isEqualToString:@""]) {
        dict[@"category_filter"] = finalCategoriesString;
    }
    
    if (radiusFilter > 0) {
        dict[@"radius_filter"] = [NSString stringWithFormat:@"%ld", (long)radiusFilter];
    }
    
    if (dealsFilter == true) {
        dict[@"deals_filter"] = @"1";
    }
    
    if (![locationKey isEqualToString:@""] && ![locationValue isEqualToString:@""]) {
        dict[locationKey] = locationValue;
    }
    
    NSDictionary *objectDict = [[NSDictionary alloc] initWithDictionary:dict];
    queryParams.paramsDict = objectDict;
    
    return queryParams;
}

+ (CDYelpQueryParams *)phoneSearchEndpointQueryParamsWithPhoneNumber:(NSString *)phoneNumber
                                                     withCountryCode:(NSString *)countryCode
                                                      withCategories:(NSArray *)categories {
    
    CDYelpQueryParams *queryParams = [[CDYelpQueryParams alloc] init];
    
    NSString *finalCategoriesString = @"";
    
    if (categories != nil) {
        if (categories.count > 0) {
            NSMutableString *categoriesString = [[NSMutableString alloc] initWithString:@""];
            for (NSString *yelpCategoryID in categories) {
                [categoriesString appendFormat:@"%@,", yelpCategoryID];
            }
            
            finalCategoriesString = [categoriesString substringToIndex:[categoriesString length] - 1];
        }
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (phoneNumber != nil && ![phoneNumber isEqualToString:@""]) {
        dict[@"phone"] = phoneNumber;
    }
    
    if (countryCode != nil && ![countryCode isEqualToString:@""]) {
        dict[@"cc"] = countryCode;
    }
    
    if (![finalCategoriesString isEqualToString:@""]) {
        dict[@"category"] = finalCategoriesString;
    }
    
    NSDictionary *objectDict = [[NSDictionary alloc] initWithDictionary:dict];
    queryParams.paramsDict = objectDict;
    
    return queryParams;
}

@end
