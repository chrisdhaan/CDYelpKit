//
//  CDYelpRegionCenter.h
//  Pods
//
//  Created by Christopher de Haan on 8/8/16.
//
//

#import <Mantle/Mantle.h>

@interface CDYelpRegionCenter : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSNumber *latitude;
@property (copy, nonatomic, readonly) NSNumber *longitude;

@end
