//
//  CDYelpUser.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Mantle/Mantle.h>

@interface CDYelpUser : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *id;
@property (copy, nonatomic, readonly) NSURL *image_url;
@property (copy, nonatomic, readonly) NSString *name;

@end
