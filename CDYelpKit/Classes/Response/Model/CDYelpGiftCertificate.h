//
//  CDYelpGiftCertificate.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Mantle/Mantle.h>

@interface CDYelpGiftCertificate : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *id;
@property (copy, nonatomic, readonly) NSURL *url;
@property (copy, nonatomic, readonly) NSURL *image_url;
@property (copy, nonatomic, readonly) NSString *currency_code;
@property (copy, nonatomic, readonly) NSString *unused_balances;
@property (copy, nonatomic, readonly) NSArray *options;

@end
