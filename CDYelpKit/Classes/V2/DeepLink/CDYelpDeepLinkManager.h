//
//  CDYelpDeepLinkManager.h
//  Pods
//
//  Created by Christopher de Haan on 7/30/16.
//
//

#import <Foundation/Foundation.h>

@interface CDYelpDeepLinkManager : NSObject

- (void)openYelp;
- (void)openYelpToSearchWithTerms:(NSArray * _Nullable)terms
                     withCategory:(NSString * _Nullable)category
                     withLocation:(NSString * _Nullable)location;
- (void)openYelpToBusiness:(NSString * _Nonnull)businessId;
- (void)openYelpToCheckins;
- (void)openYelpToNearbyCheckins;
- (void)openYelpToRankedCheckins;

- (BOOL)isYelpInstalled;

@end
