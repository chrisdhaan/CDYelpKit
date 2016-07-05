//
//  CDYelpDeal.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Mantle/Mantle.h>

@interface CDYelpDeal : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *id;
@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSURL *url;
@property (copy, nonatomic, readonly) NSURL *image_url;
@property (copy, nonatomic, readonly) NSString *currency_code;
@property (copy, nonatomic, readonly) NSDate *time_start;
@property (copy, nonatomic, readonly) NSDate *time_end;
@property (nonatomic, readonly) bool is_popular;
@property (copy, nonatomic, readonly) NSString *what_you_get;
@property (copy, nonatomic, readonly) NSString *important_restrictions;
@property (copy, nonatomic, readonly) NSString *additional_restrictions;
@property (copy, nonatomic, readonly) NSArray *options;

@end
