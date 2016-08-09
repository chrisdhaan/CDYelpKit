//
//  CDYelpRegion.h
//  Pods
//
//  Created by Christopher de Haan on 8/8/16.
//
//

#import <Mantle/Mantle.h>

@class CDYelpRegionSpan, CDYelpRegionCenter;

@interface CDYelpRegion : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) CDYelpRegionSpan *span;
@property (copy, nonatomic, readonly) CDYelpRegionCenter *center;

@end
