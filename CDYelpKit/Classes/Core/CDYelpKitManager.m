//
//  CDYelpKit.m
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

#import <CoreLocation/CoreLocation.h>

#import "CDYelpKitManager.h"

#import "CDYelpAPIClient.h"
#import "CDYelpModels.h"
#import "CDYelpOAuthManager.h"
#import "CDYelpResponses.h"

@implementation CDYelpKitManager

static NSString *YelpAPIV2Endpoint = @"https://api.yelp.com/v2/";

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
        
        CDYelpOAuthManager *yelpOAuthMananger = [[CDYelpOAuthManager alloc] initWithBaseURL:[NSURL URLWithString:YelpAPIV2Endpoint]
                                                                 consumerKey:consumerKey
                                                              consumerSecret:consumerSecret
                                                                       token:token
                                                                 tokenSecret:tokenSecret];
        self.yelpApiClient = [[CDYelpAPIClient alloc] initWithOAuthManager:yelpOAuthMananger];
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
    
    NSAssert(businessId != nil && ![businessId isEqualToString:@""], @"A business ID is required to query the Yelp Business Search endpoint.");
    
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
                           completionBlock:(void (^)(BOOL, NSError * _Nullable, CDYelpSearchResults * _Nullable))block {
    
    NSAssert(sortType <= 3 && sortType >= 0, @"The provided sort type is not a CDYelpSortType. Please provide a valid CDYelpSortType.");
    NSAssert(radiusFilter <= 40000, @"The provided radius is larger than allowed by the Yelp Search query. Please provide a radius between 0 and 40000.");
    
    CDYelpQueryParams *yelpQueryParams = [CDYelpQueryParams searchEndpointQueryParamsWithSearchTerm:searchTerm withLimit:limit withOffset:offset withSortType:sortType withCategories:categories withRadiusFilter:radiusFilter withDealsFilter:dealsFilter withRequestLocation:requestLocation];
    
    [self.yelpApiClient GET:@"search" parameters:yelpQueryParams.paramsDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, CDYelpSearchResponse * _Nullable responseObject) {
        block(YES, nil, responseObject.result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        block(NO, error, nil);
    }];
}

- (void)searchYelpBusinessesWithPhoneNumber:(NSString *)phoneNumber
                              byCountryCode:(NSString *)countryCode
                             withCategories:(NSArray *)categories
                            completionBlock:(void (^)(BOOL, NSError * _Nullable, CDYelpSearchResults * _Nullable))block {
    
    NSAssert(phoneNumber != nil && ![phoneNumber isEqualToString:@""], @"A phone number is required to query the Yelp Phone Search endpoint.");
    
    CDYelpQueryParams *yelpQueryParams = [CDYelpQueryParams phoneSearchEndpointQueryParamsWithPhoneNumber:phoneNumber withCountryCode:countryCode withCategories:categories];
    
    [self.yelpApiClient GET:@"phone_search" parameters:yelpQueryParams.paramsDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, CDYelpSearchResponse * _Nullable responseObject) {
        block(YES, nil, responseObject.result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        block(NO, error, nil);
    }];
}

#pragma mark - Helper Methods

- (void)cancelAllPendingAPIRequests {
    [self.yelpApiClient.operationQueue cancelAllOperations];
}

@end
