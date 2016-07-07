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

- (instancetype _Nullable)initWithConsumerKey:(NSString * _Nonnull)consumerKey
                               consumerSecret:(NSString * _Nonnull)consumerSecret
                                        token:(NSString * _Nonnull)token
                                  tokenSecret:(NSString * _Nonnull)tokenSecret {
    
    self = [super init];
    if (self) {
        
        NSAssert(consumerKey != nil && ![consumerKey isEqualToString:@""], @"A consumer key must be provided to utilize CDYelpKit.");
        NSAssert(consumerSecret != nil && ![consumerSecret isEqualToString:@""], @"A consumer secret must be provided to utilize CDYelpKit.");
        NSAssert(token != nil && ![token isEqualToString:@""], @"A token must be provided to utilize CDYelpKit.");
        NSAssert(tokenSecret != nil && ![tokenSecret isEqualToString:@""], @"A token secret must be provided to utilize CDYelpKit.");
        
        self.yelpApiClient = [[CDYelpAPIClient alloc] initWithBaseURL:[NSURL URLWithString:YelpEndpoint] consumerKey:consumerKey consumerSecret:consumerSecret token:token tokenSecret:tokenSecret];
    }
    return self;
}

#pragma mark - Networking Methods

- (void)getBusinessDetailsForBusinessId:(NSString *)businessId
                           byCoutryCode:(NSString *)countryCode
                         byLanguageCode:(NSString *)languageCode
                     withLangaugeFilter:(BOOL)languageFilter
                     includeActionLinks:(BOOL)actionLinks
                        completionBlock:(void (^)(BOOL, NSError * _Nullable, CDYelpDetailedBusiness * _Nullable))block {
    
    NSAssert(businessId != nil && ![businessId isEqualToString:@""], @"A business ID is required to query the Yelp business endpoint.");
    
    NSDictionary *params = [self generateYelpBusinessParametersWithCountryCode:countryCode withLanguageCode:languageCode withLanguageFilter:languageFilter withActionLinks:actionLinks];
    
    [self.yelpApiClient GET:[NSString stringWithFormat:@"business/%@", businessId] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, CDYelpBusinessResponse * _Nullable responseObject) {
        block(YES, nil, responseObject.result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        block(NO, error, nil);
    }];
}

- (void)searchYelpBusinessesWithSearchTerm:(NSString *)searchTerm
                                 withLimit:(NSInteger)limit
                                withOffset:(NSInteger)offset
                              withSortType:(CDYelpSortType)sortType
                            withCategories:(NSArray *)categories
                          withRadiusFilter:(NSInteger)radiusFilter
                           withDealsFilter:(BOOL)dealsFilter
                           withCoordinates:(NSArray *)coordinates
                           completionBlock:(void (^)(BOOL, NSError * _Nullable, NSMutableArray * _Nullable))block {
    
    NSAssert(radiusFilter <= 3 && radiusFilter >= 0, @"The provided sort type is not a CDYelpSortType. Please provide a valid CDYelpSortType.");
    NSAssert(radiusFilter <= 40000, @"The provided radius is larger than allowed by the Yelp Search query. Please provide a radius between 0 and 40000.");
    
    NSDictionary *params = [self generateYelpSearchParametersWithSearchTerm:searchTerm withLimit:limit withOffset:offset withSortType:sortType withCategories:categories withRadiusFilter:radiusFilter withDealsFilter:dealsFilter withCoordinates:coordinates];
    
    [self.yelpApiClient GET:@"search" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, CDYelpSearchResponse * _Nullable responseObject) {
        block(YES, nil, responseObject.result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        block(NO, error, nil);
    }];
}

#pragma mark - Helper Methods

- (NSDictionary *)generateYelpBusinessParametersWithCountryCode:(NSString *)countryCode
                                               withLanguageCode:(NSString *)languageCode
                                             withLanguageFilter:(BOOL)languageFilter
                                                withActionLinks:(BOOL)actionLinks {
    
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
    
    NSDictionary *dictToReturn = [[NSDictionary alloc] initWithDictionary:dict];
    
    return dictToReturn;
}

- (NSDictionary *)generateYelpSearchParametersWithSearchTerm:(NSString *)searchTerm
                                                   withLimit:(NSInteger)limit
                                                  withOffset:(NSInteger)offset
                                                withSortType:(CDYelpSortType)sortType
                                              withCategories:(NSArray *)categories
                                            withRadiusFilter:(NSInteger)radiusFilter
                                             withDealsFilter:(BOOL)dealsFilter
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
