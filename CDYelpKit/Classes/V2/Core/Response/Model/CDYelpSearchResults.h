//
//  CDYelpSearchResults.h
//  Pods
//
//  Created by Christopher de Haan on 8/8/16.
//
//

#import <Mantle/Mantle.h>

@class CDYelpRegion;

@interface CDYelpSearchResults : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) CDYelpRegion *region;
@property (copy, nonatomic, readonly) NSNumber *total;
@property (copy, nonatomic, readonly) NSArray *businesses;

@end
