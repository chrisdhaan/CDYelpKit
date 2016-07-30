//
//  CDYelpQueryParams.h
//  Pods
//
//  Created by Christopher de Haan on 7/8/16.
//
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

@end
