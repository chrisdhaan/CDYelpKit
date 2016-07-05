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

#pragma mark - Networking Methods

- (void)getBusinessDetailsForBusinessId:(NSString *)businessId withCompletionBlock:(void (^)(BOOL, CDYelpDetailedBusiness *))block {
    
    [self.yelpApiClient GET:[NSString stringWithFormat:@"business/%@", businessId] parameters:nil success:^(NSURLSessionDataTask *task, CDYelpBusinessResponse *responseObject) {
        block(YES, responseObject.result);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        block(NO, nil);
    }];
}

- (void)searchYelpBusinessesWithCategories:(NSArray *)categories withCoordinates:(NSArray *)coordinates withCompletionBlock:(void (^)(BOOL, NSMutableArray *))block {
    
    [self.yelpApiClient GET:@"search" parameters:[self generateYelpQueryDictWithCategories:categories withCoordinations:coordinates] success:^(NSURLSessionDataTask *task, CDYelpSearchResponse *responseObject) {
        block(YES, responseObject.result);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        block(NO, nil);
    }];
}

#pragma mark - Helper Methods

- (NSDictionary *)generateYelpQueryDictWithCategories:(NSArray *)categories withCoordinations:(NSArray *)coordinates {
    
    NSString *finalCategoriesString = @"";
    
    if (categories.count > 0) {
        NSMutableString *categoriesString = [[NSMutableString alloc] initWithString:@""];
        for (NSString *yelpCategoryID in categories) {
            [categoriesString appendFormat:@"%@,", yelpCategoryID];
        }
        
        finalCategoriesString = [categoriesString substringToIndex:[categoriesString length] - 1];
    }
    
    NSString *locationKey = @"";
    NSString *locationValue = @"";

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
    
    NSDictionary *dict = @{locationKey : locationValue,
                           @"limit" : @"20",
                           @"category_filter" : finalCategoriesString,
                           @"radius" : @"250",
                           @"sort" : @"1"};
    
    return dict;
}

- (NSString *)getCurrentDateString {
    
    NSDate *todaysDate = [NSDate date];
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:todaysDate];
    
    return dateString;
}

@end
