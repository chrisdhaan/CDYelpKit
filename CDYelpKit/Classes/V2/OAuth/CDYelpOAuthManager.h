//
//  CDYelpOAuthManager.h
//  Pods
//
//  Created by Christopher de Haan on 7/28/16.
//
//

#import <BDBOAuth1Manager/BDBOAuth1RequestSerializer.h>
#import <Foundation/Foundation.h>

@interface CDYelpOAuthManager : NSObject

@property (nonatomic) BDBOAuth1RequestSerializer *requestSerializer;

@property (nonatomic, assign, readonly, getter = isAuthorized) BOOL authorized;

@property (copy, nonatomic, readwrite) NSURL *baseURL;
@property (copy, nonatomic, readwrite) NSString *consumerKey;
@property (copy, nonatomic, readwrite) NSString *consumerSecret;
@property (copy, nonatomic, readwrite) NSString *token;
@property (copy, nonatomic, readwrite) NSString *tokenSecret;

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                    consumerKey:(NSString *)consumerKey
                 consumerSecret:(NSString *)consumerSecret
                          token:(NSString *)token
                    tokenSecret:(NSString *)tokenSecret;

- (BOOL)deauthorize;

@end
