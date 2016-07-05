//
//  CDYelpGiftCertificateOption.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//

#import <Mantle/Mantle.h>

@interface CDYelpGiftCertificateOption : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSNumber *price;
@property (copy, nonatomic, readonly) NSString *formatted_price;

@end
