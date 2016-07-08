//
//  CDYelpDetailedBusiness.m
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import "CDYelpDetailedBusiness.h"

#import "CDYelpLocation.h"
#import "CDYelpReview.h"

@implementation CDYelpDetailedBusiness

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    NSDictionary *defaults = @{
                               @"id": @"",
                               @"is_claimed": @NO,
                               @"is_closed": @NO,
                               @"name": @"",
                               @"image_url": [NSURL URLWithString:@""],
                               @"url": [NSURL URLWithString:@""],
                               @"mobile_url": [NSURL URLWithString:@""],
                               @"phone": @"",
                               @"display_phone": @"",
                               @"review_count": [NSNumber numberWithInt:0],
                               @"categories": @[],
                               @"distance": [NSNumber numberWithInt:0],
                               @"rating": [NSNumber numberWithInt:0],
                               @"rating_img_url": [NSURL URLWithString:@""],
                               @"rating_img_url_small": [NSURL URLWithString:@""],
                               @"rating_img_url_large": [NSURL URLWithString:@""],
                               @"snippet_text": @"",
                               @"snippet_image_url": [NSURL URLWithString:@""],
                               @"location": [CDYelpLocation new],
                               @"deals": @[],
                               @"gift_certificates": @[],
                               @"menu_provider": @"",
                               @"menu_date_updated": [NSDate new],
                               @"reservation_url": [NSURL URLWithString:@""],
                               @"eat24_url": [NSURL URLWithString:@""],
                               @"reviews": @[]
                               };
    dictionaryValue = [defaults mtl_dictionaryByAddingEntriesFromDictionary:dictionaryValue];
    return [super initWithDictionary:dictionaryValue error:error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id": @"id",
             @"is_claimed": @"is_claimed",
             @"is_closed": @"is_closed",
             @"name": @"name",
             @"image_url": @"image_url",
             @"url": @"url",
             @"mobile_url": @"mobile_url",
             @"phone": @"phone",
             @"display_phone": @"display_phone",
             @"review_count": @"review_count",
             @"categories": @"categories",
             @"distance": @"distance",
             @"rating": @"rating",
             @"rating_img_url": @"rating_img_url",
             @"rating_img_url_small": @"rating_img_url_small",
             @"rating_img_url_large": @"rating_img_url_large",
             @"snippet_text": @"snippet_text",
             @"snippet_image_url": @"snippet_image_url",
             @"location": @"location",
             @"deals": @"deals",
             @"gift_certificates": @"gift_certificates",
             @"menu_provider": @"menu_provider",
             @"menu_date_updated": @"menu_date_updated",
             @"reservation_url": @"reservation_url",
             @"eat24_url": @"eat24_url",
             @"reviews": @"reviews"
             };
}

+ (NSValueTransformer *)reviewsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CDYelpReview class]];
}

@end
