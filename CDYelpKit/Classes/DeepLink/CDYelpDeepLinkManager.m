//
//  CDYelpDeepLinkManager.m
//  Pods
//
//  Created by Christopher de Haan on 7/30/16.
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
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"yelp4:///search%@", finalQueryString]]];
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
