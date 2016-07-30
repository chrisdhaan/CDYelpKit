//
//  CDYelpOAuthManager.m
//  Pods
//
//  Created by Christopher de Haan on 7/28/16.
//
//

#import "CDYelpOAuthManager.h"

@implementation CDYelpOAuthManager

#pragma mark - Initialization Methods

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                    consumerKey:(NSString *)consumerKey
                 consumerSecret:(NSString *)consumerSecret
                          token:(NSString *)token
                    tokenSecret:(NSString *)tokenSecret {
    self = [super init];
    
    if (self) {
        self.baseURL = baseURL;
        self.consumerKey = consumerKey;
        self.consumerSecret = consumerSecret;
        self.token = token;
        self.tokenSecret = tokenSecret;
        
        self.requestSerializer  = [BDBOAuth1RequestSerializer serializerForService:baseURL.host
                                                                   withConsumerKey:consumerKey
                                                                    consumerSecret:consumerSecret];
        BDBOAuth1Credential *accessToken = [[BDBOAuth1Credential alloc] initWithToken:token
                                                                               secret:tokenSecret
                                                                           expiration:nil];
        [self.requestSerializer saveAccessToken:accessToken];
    }
    
    return self;
}

#pragma mark - Authorization Status

- (BOOL)isAuthorized {
    return (self.requestSerializer.accessToken && !self.requestSerializer.accessToken.expired);
}

- (BOOL)deauthorize {
    return [self.requestSerializer removeAccessToken];
}

@end
