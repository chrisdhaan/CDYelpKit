//
//  CDYelpAPIClient.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpAPIClient.h"

#import "CDYelpModels.h"
#import "CDYelpOAuthManager.h"
#import "CDYelpResponses.h"

@implementation CDYelpAPIClient

#pragma mark - Overcoat Methods

+ (NSDictionary *)errorModelClassesByResourcePath {
    return @{
             @"**": [CDYelpError class]
             };
}

+ (NSDictionary *)responseClassesByResourcePath {
    return @{
             @"business/**": [CDYelpBusinessResponse class],
             @"search": @{
                     @"400": [CDYelpErrorResponse class],
                     @"*": [CDYelpSearchResponse class]
                     }
             };
    
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
             @"business/**": [CDYelpDetailedBusiness class],
             @"search": @{
                     @"400": [CDYelpError class],
                     @"*": [CDYelpBusiness class]
                     }
             };
}

#pragma mark - Initialization

- (instancetype)initWithOAuthManager:(CDYelpOAuthManager *)oAuthManager {
    self = [super initWithBaseURL:oAuthManager.baseURL];
    
    if (self) {
        self.oAuthManager = oAuthManager;
        self.requestSerializer = oAuthManager.requestSerializer;
    }
    
    return self;
}


@end
