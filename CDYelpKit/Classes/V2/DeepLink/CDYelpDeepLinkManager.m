//
//  CDYelpDeepLinkManager.m
//  Pods
//
//  Created by Christopher de Haan on 7/30/16.
//
//

#import "CDYelpDeepLinkManager.h"

@implementation CDYelpDeepLinkManager

#pragma mark - Deep Link Methods

- (void)openYelp {
    if ([self isYelpInstalled]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"yelp4:"]];
    }
}

- (void)openYelpToSearchWithTerms:(NSArray *)terms
                     withCategory:(NSString *)category
                     withLocation:(NSString *)location {
    if ([self isYelpInstalled]) {
        
        NSMutableString *finalQueryString = [[NSMutableString alloc] initWithString:@""];
        
        if (terms != nil || ![category isEqualToString:@""] || ![location isEqualToString:@""]) {
            [finalQueryString appendString:@"?"];
        }
        
        NSMutableString *termsString = [[NSMutableString alloc] initWithString:@""];
        
        if (terms != nil) {
            if (terms.count > 0) {
                // Loop through terms and add to termsString
            }
        }
        
        [finalQueryString appendFormat:@"terms=%@", termsString];
        
        if (![termsString isEqualToString:@""] && ![category isEqualToString:@""]) {
            [finalQueryString appendFormat:@"&category=%@", category];
        } else if (![category isEqualToString:@""]) {
            [finalQueryString appendFormat:@"category=%@", category];
        } else {
        }
        
        if ((![termsString isEqualToString:@""] || ![category isEqualToString:@""]) && ![location isEqualToString:@""]) {
            [finalQueryString appendFormat:@"&location=%@", location];
        } else if (![location isEqualToString:@""]) {
            [finalQueryString appendFormat:@"location=%@", category];
        } else {
        }
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"yelp4:///search%@"]]];
    }
}

- (void)openYelpToBusiness:(NSString *)businessId {
    if ([self isYelpInstalled]) {
        
        NSAssert(businessId != nil && ![businessId isEqualToString:@""], @"A business ID is required to open the Yelp app to a specific business page.");
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"yelp4:///biz/%@", businessId]]];
    }
}

- (void)openYelpToCheckins {
    if ([self isYelpInstalled]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"yelp4:///check_ins"]];
    }
}

- (void)openYelpToNearbyCheckins {
    if ([self isYelpInstalled]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"yelp4:///check_in/nearby"]];
    }
}

- (void)openYelpToRankedCheckins {
    if ([self isYelpInstalled]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"yelp4:///check_in/rankings"]];
    }
}

#pragma mark - Helper Methods

- (BOOL)isYelpInstalled {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"yelp4:"]];
}

@end
