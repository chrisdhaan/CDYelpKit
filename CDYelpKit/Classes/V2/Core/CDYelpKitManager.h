//
//  CDYelpKit.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Foundation/Foundation.h>

#import "CDYelpSortType.h"

@class CDYelpAPIClient, CDYelpDetailedBusiness, CDYelpRequestLocation;

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
                           completionBlock:(void (^ _Nullable)(BOOL successful, NSError * _Nullable error, NSMutableArray * _Nullable results))block;

@end
