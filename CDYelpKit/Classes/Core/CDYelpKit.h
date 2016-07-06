//
//  CDYelpKit.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Foundation/Foundation.h>

@class CDYelpAPIClient, CDYelpDetailedBusiness;

@interface CDYelpKit : NSObject

@property (strong, nonatomic) CDYelpAPIClient * _Nonnull yelpApiClient;

- (instancetype _Nullable)initWithConsumerKey:(NSString * _Nonnull)consumerKey
                               consumerSecret:(NSString * _Nonnull)consumerSecret
                                        token:(NSString * _Nonnull)token
                                  tokenSecret:(NSString * _Nonnull)tokenSecret;

- (void)getBusinessDetailsForBusinessId:(NSString * _Nonnull)businessId
                           byCoutryCode:(NSString * _Nullable)countryCode
                         byLanguageCode:(NSString * _Nullable)languageCode
                     withLangaugeFilter:(NSNumber * _Nullable)languageFilter
                     includeActionLinks:(NSNumber * _Nullable)actionLinks
                        completionBlock:(void (^ _Nullable)(BOOL, CDYelpDetailedBusiness * _Nullable))block;

- (void)searchYelpBusinessesWithSearchTerm:(NSString * _Nullable)searchTerm
                                 withLimit:(NSNumber * _Nullable)limit
                                withOffset:(NSNumber * _Nullable)offset
                              withSortType:(NSNumber * _Nullable)sortType
                            withCategories:(NSArray * _Nullable)categories
                          withRadiusFilter:(NSNumber * _Nullable)radiusFilter
                           withDealsFilter:(NSNumber * _Nullable)dealsFilter
                           withCoordinates:(NSArray * _Nullable)coordinates
                           completionBlock:(void (^ _Nullable)(BOOL, NSMutableArray * _Nullable))block;

@end
