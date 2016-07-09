//
//  CDYelpQueryParams.m
//  Pods
//
//  Created by Christopher de Haan on 7/8/16.
//
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
        } else {
        }
    }
    
    NSString *locationKey = @"";
    NSString *locationValue = @"";
    
    if (requestLocation != nil) {
        if (requestLocation.requestLocationType == kCDYelpRequestLocationTypeCurrentLocation) {
            locationKey = @"ll";
            locationValue = [NSString stringWithFormat:@"%f,%f", requestLocation.currentLocationCoordinate.latitude, requestLocation.currentLocationCoordinate.longitude];
        } else if (requestLocation.requestLocationType == kCDYelpRequestLocationTypeBoundingBox) {
            locationKey = @"bounds";
            locationValue = [NSString stringWithFormat:@"%f,%f|%f,%f", requestLocation.boundingBox.southWestCoordinate.latitude, requestLocation.boundingBox.southWestCoordinate.longitude, requestLocation.boundingBox.northEastCoordinate.latitude, requestLocation.boundingBox.northEastCoordinate.longitude];
        } else {
        }
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (searchTerm != nil && ![searchTerm isEqualToString:@""]) {
        dict[@"term"] = [NSString stringWithFormat:@"%@", searchTerm];
    }
    
    dict[@"limit"] = [NSString stringWithFormat:@"%ld", (long)limit];
    
    if (offset > 0) {
        dict[@"offset"] = [NSString stringWithFormat:@"%ld", (long)offset];
    }
    
    if (sortType != kCDYelpSortTypeNone) {
        dict[@"sort"] = [NSString stringWithFormat:@"%ld", (long)sortType];
    }
    
    if (![finalCategoriesString isEqualToString:@""]) {
        dict[@"category_filter"] = finalCategoriesString;
    }
    
    dict[@"radius_filter"] = [NSString stringWithFormat:@"%ld", (long)radiusFilter];
    
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

@end
