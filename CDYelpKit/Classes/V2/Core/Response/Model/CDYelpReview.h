//
//  CDYelpReview.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Mantle/Mantle.h>

@class CDYelpUser;

@interface CDYelpReview : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *id;
@property (copy, nonatomic, readonly) NSNumber *rating;
@property (copy, nonatomic, readonly) NSURL *rating_image_url;
@property (copy, nonatomic, readonly) NSURL *rating_image_small_url;
@property (copy, nonatomic, readonly) NSURL *rating_image_large_url;
@property (copy, nonatomic, readonly) NSString *excerpt;
@property (copy, nonatomic, readonly) NSDate *time_created;
@property (copy, nonatomic, readonly) CDYelpUser *user;

@end
