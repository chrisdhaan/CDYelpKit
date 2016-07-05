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

@property (strong, nonatomic) CDYelpAPIClient *yelpApiClient;

- (void)getBusinessDetailsForBusinessId:(NSString *)businessId withCompletionBlock:(void (^)(BOOL success, CDYelpDetailedBusiness *business))block;
- (void)searchYelpBusinessesWithCategories:(NSArray *)categories withCoordinates:(NSArray *)coordinates withCompletionBlock:(void (^)(BOOL success, NSMutableArray *results))block;

@end
