//
//  CDYelpBusiness.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Mantle/Mantle.h>

@class CDYelpLocation;

@interface CDYelpBusiness : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *id;
@property (nonatomic, readonly) bool is_claimed;
@property (nonatomic, readonly) bool is_closed;
@property (copy, nonatomic, readonly) NSString *name;
@property (copy, nonatomic, readonly) NSURL *image_url;
@property (copy, nonatomic, readonly) NSURL *url;
@property (copy, nonatomic, readonly) NSURL *mobile_url;
@property (copy, nonatomic, readonly) NSString *phone;
@property (copy, nonatomic, readonly) NSString *display_phone;
@property (copy, nonatomic, readonly) NSNumber *review_count;
@property (copy, nonatomic, readonly) NSArray *categories;
@property (copy, nonatomic, readonly) NSNumber *distance;
@property (copy, nonatomic, readonly) NSNumber *rating;
@property (copy, nonatomic, readonly) NSURL *rating_img_url;
@property (copy, nonatomic, readonly) NSURL *rating_img_url_small;
@property (copy, nonatomic, readonly) NSURL *rating_img_url_large;
@property (copy, nonatomic, readonly) NSString *snippet_text;
@property (copy, nonatomic, readonly) NSURL *snippet_image_url;
@property (copy, nonatomic, readonly) CDYelpLocation *location;
@property (copy, nonatomic, readonly) NSArray *deals;
@property (copy, nonatomic, readonly) NSArray *gift_certificates;
@property (copy, nonatomic, readonly) NSString *menu_provider;
@property (copy, nonatomic, readonly) NSDate *menu_date_updated;
@property (copy, nonatomic, readonly) NSURL *reservation_url;
@property (copy, nonatomic, readonly) NSURL *eat24_url;

@end
