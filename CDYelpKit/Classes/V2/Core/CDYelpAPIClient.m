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

@dynamic requestSerializer;

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

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                    consumerKey:(NSString *)consumerKey
                 consumerSecret:(NSString *)consumerSecret
                          token:(NSString *)token
                    tokenSecret:(NSString *)tokenSecret {
    self = [super initWithBaseURL:baseURL];
    
    if (self) {
        self.requestSerializer  = [BDBOAuth1RequestSerializer serializerForService:baseURL.host
                                                                   withConsumerKey:consumerKey
                                                                    consumerSecret:consumerSecret];
        BDBOAuth1Credential *accessToken = [[BDBOAuth1Credential alloc] initWithToken:token secret:tokenSecret expiration:nil];
        [self.requestSerializer saveAccessToken:accessToken];
    }
    
    return self;
}

//#pragma mark - Authorization Status
//
//- (BOOL)isAuthorized {
//    return (self.requestSerializer.accessToken && !self.requestSerializer.accessToken.expired);
//}
//
//- (BOOL)deauthorize {
//    return [self.requestSerializer removeAccessToken];
//}
//
//#pragma mark - OAuth Handshake
//
//- (void)fetchRequestTokenWithPath:(NSString *)requestPath
//                           method:(NSString *)method
//                      callbackURL:(NSURL *)callbackURL
//                            scope:(NSString *)scope
//                          success:(void (^)(BDBOAuth1Credential *requestToken))success
//                          failure:(void (^)(NSError *error))failure {
//    self.requestSerializer.requestToken = nil;
//    
//    AFHTTPResponseSerializer *defaultSerializer = self.responseSerializer;
//    self.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    NSMutableDictionary *parameters = [[self.requestSerializer OAuthParameters] mutableCopy];
//    parameters[BDBOAuth1OAuthCallbackParameter] = [callbackURL absoluteString];
//    
//    if (scope && !self.requestSerializer.accessToken) {
//        parameters[@"scope"] = scope;
//    }
//    
//    NSString *URLString = [[NSURL URLWithString:requestPath relativeToURL:self.baseURL] absoluteString];
//    NSError *error;
//    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:&error];
//    
//    if (error) {
//        failure(error);
//        
//        return;
//    }
//    
//    void (^completionBlock)(NSURLResponse * __unused, id, NSError *) = ^(NSURLResponse * __unused response, id responseObject, NSError *error) {
//        self.responseSerializer = defaultSerializer;
//        
//        if (error) {
//            failure(error);
//            
//            return;
//        }
//        
//        BDBOAuth1Credential *requestToken = [BDBOAuth1Credential credentialWithQueryString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
//        self.requestSerializer.requestToken = requestToken;
//        
//        success(requestToken);
//    };
//    
//    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:completionBlock];
//    [task resume];
//}
//
//- (void)fetchAccessTokenWithPath:(NSString *)accessPath
//                          method:(NSString *)method
//                    requestToken:(BDBOAuth1Credential *)requestToken
//                         success:(void (^)(BDBOAuth1Credential *accessToken))success
//                         failure:(void (^)(NSError *error))failure {
//    if (!requestToken.token || !requestToken.verifier) {
//        NSError *error = [[NSError alloc] initWithDomain:BDBOAuth1ErrorDomain
//                                                    code:NSURLErrorBadServerResponse
//                                                userInfo:@{NSLocalizedFailureReasonErrorKey:@"Invalid OAuth response received from server."}];
//        
//        failure(error);
//        
//        return;
//    }
//    
//    AFHTTPResponseSerializer *defaultSerializer = self.responseSerializer;
//    self.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    NSMutableDictionary *parameters = [[self.requestSerializer OAuthParameters] mutableCopy];
//    parameters[BDBOAuth1OAuthTokenParameter]    = requestToken.token;
//    parameters[BDBOAuth1OAuthVerifierParameter] = requestToken.verifier;
//    
//    NSString *URLString = [[NSURL URLWithString:accessPath relativeToURL:self.baseURL] absoluteString];
//    NSError *error;
//    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:&error];
//    
//    if (error) {
//        failure(error);
//        
//        return;
//    }
//    
//    void (^completionBlock)(NSURLResponse * __unused, id, NSError *) = ^(NSURLResponse * __unused response, id responseObject, NSError *error) {
//        self.responseSerializer = defaultSerializer;
//        self.requestSerializer.requestToken = nil;
//        
//        if (error) {
//            failure(error);
//            
//            return;
//        }
//        
//        BDBOAuth1Credential *accessToken = [BDBOAuth1Credential credentialWithQueryString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
//        [self.requestSerializer saveAccessToken:accessToken];
//        
//        success(accessToken);
//    };
//    
//    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:completionBlock];
//    [task resume];
//}

@end
