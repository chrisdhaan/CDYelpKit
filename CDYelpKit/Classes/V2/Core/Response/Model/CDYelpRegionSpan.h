//
//  CDYelpRegionSpan.h
//  Pods
//
//  Created by Christopher de Haan on 8/8/16.
//
//

#import <Mantle/Mantle.h>

@interface CDYelpRegionSpan : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSNumber *latitudeDelta;
@property (copy, nonatomic, readonly) NSNumber *longitudeDelta;

@end
