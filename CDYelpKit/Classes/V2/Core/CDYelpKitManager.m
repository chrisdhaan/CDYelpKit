//
//  CDYelpKit.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <CoreLocation/CoreLocation.h>

#import "CDYelpKitManager.h"

#import "CDYelpAPIClient.h"
#import "CDYelpModels.h"
#import "CDYelpResponses.h"

@implementation CDYelpKitManager

static NSString *YelpEndpoint = @"https://api.yelp.com/v2/";

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
    
    CDYelpQueryParams *yelpQueryParams = [CDYelpQueryParams businessEndpointQueryParamsWithCoutryCode:countryCode withLanguageCode:languageCode withLangaugeFilter:languageFilter withActionLinks:actionLinks];
    
    [self.yelpApiClient GET:[NSString stringWithFormat:@"business/%@", businessId] parameters:yelpQueryParams.paramsDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, CDYelpBusinessResponse * _Nullable responseObject) {
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
                       withRequestLocation:(CDYelpRequestLocation *)requestLocation
                           completionBlock:(void (^)(BOOL, NSError * _Nullable, NSMutableArray * _Nullable))block {
    
    NSAssert(radiusFilter <= 3 && radiusFilter >= 0, @"The provided sort type is not a CDYelpSortType. Please provide a valid CDYelpSortType.");
    NSAssert(radiusFilter <= 40000, @"The provided radius is larger than allowed by the Yelp Search query. Please provide a radius between 0 and 40000.");
    
    CDYelpQueryParams *yelpQueryParams = [CDYelpQueryParams searchEndpointQueryParamsWithSearchTerm:searchTerm withLimit:limit withOffset:offset withSortType:sortType withCategories:categories withRadiusFilter:radiusFilter withDealsFilter:dealsFilter withRequestLocation:requestLocation];
    
    [self.yelpApiClient GET:@"search" parameters:yelpQueryParams.paramsDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, CDYelpSearchResponse * _Nullable responseObject) {
        block(YES, nil, responseObject.result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        block(NO, error, nil);
    }];
}

@end
