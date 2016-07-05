//
//  CDYelpAPIClient.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpAPIClient.h"

#import "CDYelpModels.h"
#import "CDYelpResponses.h"

@implementation CDYelpAPIClient

#pragma mark - Overcoat Methods

+ (Class)errorModelClass {
    return [CDYelpError class];
}

+ (NSDictionary *)responseClassesByResourcePath {
    return @{
             @"business/**": [CDYelpBusinessResponse class],
             @"search": [CDYelpSearchResponse class]
             };
    
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
             @"business/**" : [CDYelpDetailedBusiness class],
             @"search": [CDYelpBusiness class]
             };
}

#pragma mark - Initialization

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                    consumerKey:(NSString *)consumerKey
                 consumerSecret:(NSString *)consumerSecret
                          token:(NSString *)token
                    tokenSecret:(NSString *)tokenSecret {
    self = [super initWithBaseURL:baseURL];
    
    if (self) {
        self.oAuthRequestSerializer  = [BDBOAuth1RequestSerializer serializerForService:baseURL.host
                                                                   withConsumerKey:consumerKey
                                                                    consumerSecret:consumerSecret];
        BDBOAuth1Credential *accessToken = [[BDBOAuth1Credential alloc] initWithToken:token secret:tokenSecret expiration:nil];
        [self.oAuthRequestSerializer saveAccessToken:accessToken];
    }
    
    return self;
}

#pragma mark - Authorization Status

- (BOOL)isAuthorized {
    return (self.oAuthRequestSerializer.accessToken && !self.oAuthRequestSerializer.accessToken.expired);
}

- (BOOL)deauthorize {
    return [self.oAuthRequestSerializer removeAccessToken];
}

#pragma mark - OAuth Handshake

- (void)fetchRequestTokenWithPath:(NSString *)requestPath
                           method:(NSString *)method
                      callbackURL:(NSURL *)callbackURL
                            scope:(NSString *)scope
                          success:(void (^)(BDBOAuth1Credential *requestToken))success
                          failure:(void (^)(NSError *error))failure {
    self.oAuthRequestSerializer.requestToken = nil;
    
    AFHTTPResponseSerializer *defaultSerializer = self.responseSerializer;
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[self.oAuthRequestSerializer OAuthParameters] mutableCopy];
    parameters[BDBOAuth1OAuthCallbackParameter] = [callbackURL absoluteString];
    
    if (scope && !self.oAuthRequestSerializer.accessToken) {
        parameters[@"scope"] = scope;
    }
    
    NSString *URLString = [[NSURL URLWithString:requestPath relativeToURL:self.baseURL] absoluteString];
    NSError *error;
    NSMutableURLRequest *request = [self.oAuthRequestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:&error];
    
    if (error) {
        failure(error);
        
        return;
    }
    
    void (^completionBlock)(NSURLResponse * __unused, id, NSError *) = ^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        self.responseSerializer = defaultSerializer;
        
        if (error) {
            failure(error);
            
            return;
        }
        
        BDBOAuth1Credential *requestToken = [BDBOAuth1Credential credentialWithQueryString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        self.oAuthRequestSerializer.requestToken = requestToken;
        
        success(requestToken);
    };
    
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:completionBlock];
    [task resume];
}

- (void)fetchAccessTokenWithPath:(NSString *)accessPath
                          method:(NSString *)method
                    requestToken:(BDBOAuth1Credential *)requestToken
                         success:(void (^)(BDBOAuth1Credential *accessToken))success
                         failure:(void (^)(NSError *error))failure {
    if (!requestToken.token || !requestToken.verifier) {
        NSError *error = [[NSError alloc] initWithDomain:BDBOAuth1ErrorDomain
                                                    code:NSURLErrorBadServerResponse
                                                userInfo:@{NSLocalizedFailureReasonErrorKey:@"Invalid OAuth response received from server."}];
        
        failure(error);
        
        return;
    }
    
    AFHTTPResponseSerializer *defaultSerializer = self.responseSerializer;
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[self.oAuthRequestSerializer OAuthParameters] mutableCopy];
    parameters[BDBOAuth1OAuthTokenParameter]    = requestToken.token;
    parameters[BDBOAuth1OAuthVerifierParameter] = requestToken.verifier;
    
    NSString *URLString = [[NSURL URLWithString:accessPath relativeToURL:self.baseURL] absoluteString];
    NSError *error;
    NSMutableURLRequest *request = [self.oAuthRequestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:&error];
    
    if (error) {
        failure(error);
        
        return;
    }
    
    void (^completionBlock)(NSURLResponse * __unused, id, NSError *) = ^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        self.responseSerializer = defaultSerializer;
        self.oAuthRequestSerializer.requestToken = nil;
        
        if (error) {
            failure(error);
            
            return;
        }
        
        BDBOAuth1Credential *accessToken = [BDBOAuth1Credential credentialWithQueryString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        [self.oAuthRequestSerializer saveAccessToken:accessToken];
        
        success(accessToken);
    };
    
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:completionBlock];
    [task resume];
}

@end
