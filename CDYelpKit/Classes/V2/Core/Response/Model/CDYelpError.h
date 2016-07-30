//
//  CDYelpError.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Mantle/Mantle.h>

@interface CDYelpError : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *text;
@property (copy, nonatomic, readonly) NSString *id;
@property (copy, nonatomic, readonly) NSString *field;

@end
