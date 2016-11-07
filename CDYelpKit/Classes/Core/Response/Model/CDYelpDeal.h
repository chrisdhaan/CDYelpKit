//
//  CDYelpDeal.h
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
