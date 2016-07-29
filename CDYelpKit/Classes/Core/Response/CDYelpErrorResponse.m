//
//  CDYelpErrorResponse.m
//  Pods
//
//  Created by Christopher de Haan on 7/9/16.
//
//

#import "CDYelpErrorResponse.h"

@implementation CDYelpErrorResponse

#pragma mark - Overcoat Methods

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
    return @"error";
}

@end
