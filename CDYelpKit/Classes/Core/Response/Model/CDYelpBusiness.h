//
//  CDYelpBusiness.h
//  Pods
//
//  Created by Christopher de Haan on 7/5/16.
//
//  Copyright (c) 2016 Christopher de Haan <contact@christopherdehaan.me>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
