//
//  CDYelpAPIClient.m
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

#import "CDYelpAPIClient.h"

#import "CDYelpModels.h"
#import "CDYelpOAuthManager.h"
#import "CDYelpResponses.h"

@implementation CDYelpAPIClient

#pragma mark - Overcoat Methods

+ (NSDictionary *)errorModelClassesByResourcePath {
    return @{
             @"**": [CDYelpError class]
             };
}

+ (NSDictionary *)responseClassesByResourcePath {
    return @{
             @"business/**": [CDYelpBusinessResponse class],
             @"search": @{
                     @"400": [CDYelpErrorResponse class],
                     @"*": [CDYelpSearchResponse class]
                     },
             @"phone_search": @{
                     @"400": [CDYelpErrorResponse class],
                     @"*": [CDYelpSearchResponse class]
                     }
             };
    
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
             @"business/**": [CDYelpDetailedBusiness class],
             @"search": @{
                     @"400": [CDYelpError class],
                     @"*": [CDYelpSearchResults class]
                     },
             @"phone_search": @{
                     @"400": [CDYelpError class],
                     @"*": [CDYelpSearchResults class]
                     }
             };
}

#pragma mark - Initialization

- (instancetype)initWithOAuthManager:(CDYelpOAuthManager *)oAuthManager {
    self = [super initWithBaseURL:oAuthManager.baseURL];
    
    if (self) {
        self.oAuthManager = oAuthManager;
        self.requestSerializer = oAuthManager.requestSerializer;
    }
    
    return self;
}


@end
