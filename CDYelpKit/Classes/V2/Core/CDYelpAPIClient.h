//
//  CDYelpAPIClient.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Overcoat/Overcoat.h>

@class CDYelpOAuthManager;

@interface CDYelpAPIClient : OVCHTTPSessionManager

@property (nonatomic, strong) CDYelpOAuthManager *oAuthManager;

- (instancetype)initWithOAuthManager:(CDYelpOAuthManager *)oAuthMananger;

@end
