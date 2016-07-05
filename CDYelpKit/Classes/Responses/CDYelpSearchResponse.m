//
//  CDYelpSearchResponse.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpSearchResponse.h"

@implementation CDYelpSearchResponse

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
    return @"businesses";
}

@end
