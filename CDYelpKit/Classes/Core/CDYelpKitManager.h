//
//  CDYelpKit.h
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

#import <Foundation/Foundation.h>

#import "CDYelpSortType.h"

@class CDYelpAPIClient, CDYelpDetailedBusiness, CDYelpRequestLocation, CDYelpSearchResults;

@interface CDYelpKitManager : NSObject

@property (strong, nonatomic) CDYelpAPIClient * _Nonnull yelpApiClient;

- (instancetype _Nullable)initWithConsumerKey:(NSString * _Nonnull)consumerKey
                               consumerSecret:(NSString * _Nonnull)consumerSecret
                                        token:(NSString * _Nonnull)token
                                  tokenSecret:(NSString * _Nonnull)tokenSecret;

- (void)getBusinessDetailsForBusinessId:(NSString * _Nonnull)businessId
                           byCoutryCode:(NSString * _Nullable)countryCode
                         byLanguageCode:(NSString * _Nullable)languageCode
                     withLangaugeFilter:(BOOL)languageFilter
                     includeActionLinks:(BOOL)actionLinks
                        completionBlock:(void (^ _Nullable)(BOOL successful, NSError * _Nullable error, CDYelpDetailedBusiness * _Nullable business))block;

- (void)searchYelpBusinessesWithSearchTerm:(NSString * _Nullable)searchTerm
                                 withLimit:(NSInteger)limit
                                withOffset:(NSInteger)offset
                              withSortType:(CDYelpSortType)sortType
                            withCategories:(NSArray * _Nullable)categories
                          withRadiusFilter:(NSInteger)radiusFilter
                           withDealsFilter:(BOOL)dealsFilter
                       withRequestLocation:(CDYelpRequestLocation * _Nullable)requestLocation
                           completionBlock:(void (^ _Nullable)(BOOL successful, NSError * _Nullable error, CDYelpSearchResults * _Nullable results))block;

- (void)searchYelpBusinessesWithPhoneNumber:(NSString * _Nonnull)phoneNumber
                              byCountryCode:(NSString * _Nullable)countryCode
                             withCategories:(NSArray * _Nullable)categories
                            completionBlock:(void (^ _Nullable)(BOOL successful, NSError * _Nullable error, CDYelpSearchResults * _Nullable results))block;

- (void)cancelAllPendingAPIRequests;

@end
