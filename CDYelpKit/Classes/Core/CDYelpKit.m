//
//  CDYelpKit.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <CoreLocation/CoreLocation.h>

#import "CDYelpKit.h"

#import "CDYelpAPIClient.h"
#import "CDYelpDetailedBusiness.h"
#import "CDYelpResponses.h"

@implementation CDYelpKit

static NSString *YelpEndpoint = @"http://api.yelp.com/v2/";

#pragma mark - Initialization Methods

- (instancetype)initWithConsumerKey:(NSString * _Nonnull)consumerKey
                     consumerSecret:(NSString * _Nonnull)consumerSecret
                              token:(NSString * _Nonnull)token
                        tokenSecret:(NSString * _Nonnull)tokenSecret {
    
    self.yelpApiClient = [[CDYelpAPIClient alloc] initWithBaseURL:YelpEndpoint consumerKey:consumerKey consumerSecret:consumerSecret token:token tokenSecret:tokenSecret];
}

#pragma mark - Networking Methods

- (void)getBusinessDetailsForBusinessId:(NSString * _Nonnull)businessId
                           byCoutryCode:(NSString * _Nullable)countryCode
                         byLanguageCode:(NSString * _Nullable)languageCode
                     withLangaugeFilter:(NSNumber * _Nullable)languageFilter
                     includeActionLinks:(NSNumber * _Nullable)actionLinks
                        completionBlock:(void (^)(BOOL, CDYelpDetailedBusiness *))block {
    
    NSDictionary *params = [self generateYelpBusinessParametersWithCountryCode:countryCode withLanguageCode:languageCode withLanguageFilter:languageFilter withActionLinks:actionLinks];
    
    [self.yelpApiClient GET:[NSString stringWithFormat:@"business/%@", businessId] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, CDYelpBusinessResponse * _Nullable responseObject) {
        block(YES, responseObject.result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        block(NO, nil);
    }];
}

- (void)searchYelpBusinessesWithSearchTerm:(NSString * _Nullable)searchTerm
                                 withLimit:(NSNumber * _Nullable)limit
                                withOffset:(NSNumber * _Nullable)offset
                              withSortType:(NSNumber * _Nullable)sortType
                            withCategories:(NSArray * _Nullable)categories
                          withRadiusFilter:(NSNumber * _Nullable)radiusFilter
                           withDealsFilter:(NSNumber * _Nullable)dealsFilter
                           withCoordinates:(NSArray * _Nullable)coordinates
                           completionBlock:(void (^)(BOOL, NSMutableArray *))block {
    
    NSDictionary *params = [self generateYelpSearchParametersWithSearchTerm:searchTerm withLimit:limit withOffset:offset withSortType:sortType withCategories:categories withRadiusFilter:radiusFilter withDealsFilter:dealsFilter withCoordinates:coordinates];
    
    [self.yelpApiClient GET:@"search" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, CDYelpSearchResponse * _Nullable responseObject) {
        block(YES, responseObject.result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        block(NO, nil);
    }];
}

#pragma mark - Helper Methods

- (NSDictionary *)generateYelpBusinessParametersWithCountryCode:(NSString *)countryCode
                                               withLanguageCode:(NSString *)languageCode
                                             withLanguageFilter:(NSNumber *)languageFilter
                                                withActionLinks:(NSNumber *)actionLinks {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (countryCode != nil) {
        dict[@"cc"] = countryCode;
    }
    if (languageCode != nil) {
        dict[@"lang"] = languageCode;
    }
    if (languageFilter != nil) {
        dict[@"lang_filter"] = [NSString stringWithFormat:@"%i", [languageFilter integerValue]];
    }
    if (actionLinks != nil) {
        dict[@"actionlinks"] = [NSString stringWithFormat:@"%i", [actionLinks integerValue]];
    }
    
    NSDictionary *dictToReturn = [[NSDictionary alloc] initWithDictionary:dict];
    
    return dictToReturn;
}

- (NSDictionary *)generateYelpSearchParametersWithSearchTerm:(NSString *)searchTerm
                                                   withLimit:(NSNumber *)limit
                                                  withOffset:(NSNumber *)offset
                                                withSortType:(NSNumber *)sortType
                                              withCategories:(NSArray *)categories
                                            withRadiusFilter:(NSNumber *)radiusFilter
                                             withDealsFilter:(NSNumber *)dealsFilter
                                             withCoordinates:(NSArray *)coordinates {
    
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

    if (coordinates != nil) {
        if (coordinates.count > 0 && coordinates.count < 2) {
            locationKey = @"ll";
            CLLocation *location = [coordinates objectAtIndex:0];
            locationValue = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
        } else if (coordinates.count >= 2) {
            locationKey = @"bounds";
            CLLocation *locationOne = [coordinates objectAtIndex:0];
            CLLocation *locationTwo = [coordinates objectAtIndex:1];
            locationValue = [NSString stringWithFormat:@"%f,%f|%f,%f", locationOne.coordinate.latitude, locationOne.coordinate.longitude, locationTwo.coordinate.latitude, locationTwo.coordinate.longitude];
        } else {
        }
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (searchTerm != nil) {
        dict[@"term"] = [NSString stringWithFormat:@"%@", searchTerm];
    }
    if (limit != nil) {
        dict[@"limit"] = [NSString stringWithFormat:@"%i", [limit integerValue]];
    }
    if (offset != nil) {
        dict[@"offset"] = [NSString stringWithFormat:@"%i", [offset integerValue]];
    }
    if (sortType != nil) {
        dict[@"sort"] = [NSString stringWithFormat:@"%i", [sortType integerValue]];
    }
    if (![finalCategoriesString isEqualToString:@""]) {
        dict[@"category_filter"] = finalCategoriesString;
    }
    if (radiusFilter != nil) {
        dict[@"radius_filter"] = [NSString stringWithFormat:@"%i", [radiusFilter integerValue]];
    }
    if (dealsFilter != nil) {
        dict[@"deals_filter"] = [NSString stringWithFormat:@"%i", [dealsFilter integerValue]];
    }
    if (![locationKey isEqualToString:@""] && ![locationValue isEqualToString:@""]) {
        dict[locationKey] = locationValue;
    }
    
    NSDictionary *dictToReturn = [[NSDictionary alloc] initWithDictionary:dict];
    
    return dictToReturn;
}

- (NSString *)getCurrentDateString {
    
    NSDate *todaysDate = [NSDate date];
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:todaysDate];
    
    return dateString;
}

@end
