//
//  CDYelpAPIClient.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <BDBOAuth1Manager/BDBOAuth1RequestSerializer.h>
#import <Overcoat/Overcoat.h>

@interface CDYelpAPIClient : OVCHTTPSessionManager

@property (nonatomic) BDBOAuth1RequestSerializer *requestSerializer;

@property (nonatomic, assign, readonly, getter = isAuthorized) BOOL authorized;

//- (BOOL)deauthorize;
- (instancetype)initWithBaseURL:(NSURL *)baseURL
                    consumerKey:(NSString *)consumerKey
                 consumerSecret:(NSString *)consumerSecret
                          token:(NSString *)token
                    tokenSecret:(NSString *)tokenSecret;
//- (void)fetchRequestTokenWithPath:(NSString *)requestPath
//                           method:(NSString *)method
//                      callbackURL:(NSURL *)callbackURL
//                            scope:(NSString *)scope
//                          success:(void (^)(BDBOAuth1Credential *requestToken))success
//                          failure:(void (^)(NSError *error))failure;
//- (void)fetchAccessTokenWithPath:(NSString *)accessPath
//                          method:(NSString *)method
//                    requestToken:(BDBOAuth1Credential *)requestToken
//                         success:(void (^)(BDBOAuth1Credential *accessToken))success
//                         failure:(void (^)(NSError *error))failure;

@end
