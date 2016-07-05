//
//  CDYelpDealOption.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Mantle/Mantle.h>

@interface CDYelpDealOption : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSURL *purchase_url;
@property (copy, nonatomic, readonly) NSNumber *price;
@property (copy, nonatomic, readonly) NSString *formatted_price;
@property (copy, nonatomic, readonly) NSNumber *original_price;
@property (copy, nonatomic, readonly) NSString *formatted_original_price;
@property (nonatomic, readonly) bool is_quantity_limited;
@property (copy, nonatomic, readonly) NSNumber *remaining_count;

@end
