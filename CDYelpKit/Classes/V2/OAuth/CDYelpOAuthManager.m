//
//  CDYelpOAuthManager.m
//  Pods
//
//  Created by Christopher de Haan on 7/28/16.
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
