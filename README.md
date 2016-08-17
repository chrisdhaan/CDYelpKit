# CDYelpKit

[![CI Status](http://img.shields.io/travis/chrisdhaan/CDYelpKit.svg?style=flat)](https://travis-ci.org/chrisdhaan/CDYelpKit)
[![Version](https://img.shields.io/cocoapods/v/CDYelpKit.svg?style=flat)](http://cocoapods.org/pods/CDYelpKit)
[![License](https://img.shields.io/cocoapods/l/CDYelpKit.svg?style=flat)](http://cocoapods.org/pods/CDYelpKit)
[![Platform](https://img.shields.io/cocoapods/p/CDYelpKit.svg?style=flat)](http://cocoapods.org/pods/CDYelpKit)

This pod is currently in development. As of release 0.9.0 the code is stable and in a usable state to install in applications.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

---

## Requirements

- iosSDK: 8.0
- [Yelp API Access](https://www.yelp.com/developers/manage_api_keys)

---

## Installation

CDYelpKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CDYelpKit"
```

## Yelp API V2 Installation

CDYelpKit currently queries Yelp API V2. In preparation for Yelp API V3 all V2 functionality has been paritioned into its own module. To integrate CDYelpKitV2 into your application, add the following line to your Podfile:

```ruby
pod "CDYelpKit/CDYelpKitV2"
```

CDYelpKitV2 is partioned into three separate modules, each of which can be installed on its own. This can be beneficial when trying to decrease the size of an application and not all pod functionality is needed.

OAuth is needed to interact with the Yelp API. To integrate OAuth into your application, add the following line to your Podfile:

```ruby
pod "CDYelpKit/CDYelpKitV2/OAuth"
```

Network requests are needed to retrieve data from the Yelp API. To integrate methods that query the various Yelp API endpoints into your application, add the following line to your Podfile:

```ruby
pod "CDYelpKit/CDYelpKitV2/Core"
```

Deep linking allows applications to make queries to the Yelp app. Each query opens either the Yelp app (if it's installed on the device) or the Yelp website to a corresponding screen. To integrate methods that query the various Yelp app endpoints into your application, add the following line to you Podfile:
```ruby
pod "CDYelpKit/CDYelpKitV2/DeepLink"
```

---

## Usage

### [OAuth](https://www.yelp.com/developers/documentation/v2/authentication) Usage

#### Initialization

```objective-c
NSURL *yelpAPIV2Endpoint = [NSURL URLWithString:@"https://api.yelp.com/v2/"];
CDYelpOAuthManager *yelpOAuthMananger = [[CDYelpOAuthManager alloc] initWithBaseURL:yelpAPIV2Endpoint
                                                                        consumerKey:@"consumerKey"
                                                                     consumerSecret:@"consumerSecret"
                                                                              token:@"token"
                                                                        tokenSecret:@"tokenSecret"];
```

### Core Usage

#### Initialization

```objective-c
CDYelpKitManager *yelpKitManager = [[CDYelpKitManager alloc] initWithConsumerKey:@"consumerKey"
                                                                  consumerSecret:@"consumerSecret"
                                                                           token:@"token"
                                                                     tokenSecret:@"tokenSecret"];
```

#### [Search API](https://www.yelp.com/developers/documentation/v2/search_api)

```objective-c
- (void)searchYelpBusinessesWithSearchTerm:(NSString * _Nullable)searchTerm                     // Optional
                                 withLimit:(NSInteger)limit                                     // Required
                                withOffset:(NSInteger)offset                                    // Required
                              withSortType:(CDYelpSortType)sortType                             // Required
                            withCategories:(NSArray * _Nullable)categories                      // Optional
                          withRadiusFilter:(NSInteger)radiusFilter                              // Required
                           withDealsFilter:(BOOL)dealsFilter                                    // Required
                       withRequestLocation:(CDYelpRequestLocation * _Nullable)requestLocation   // Optional
                           completionBlock:(void (^ _Nullable)(BOOL successful, 
                                                               NSError * _Nullable error, 
                                                               CDYelpSearchResults * _Nullable results))block;
```

#### [Business API](https://www.yelp.com/developers/documentation/v2/business)

```objective-c
- (void)getBusinessDetailsForBusinessId:(NSString * _Nonnull)businessId                         // Required
                           byCoutryCode:(NSString * _Nullable)countryCode                       // Optional
                         byLanguageCode:(NSString * _Nullable)languageCode                      // Optional
                     withLangaugeFilter:(BOOL)languageFilter                                    // Required
                     includeActionLinks:(BOOL)actionLinks                                       // Required
                        completionBlock:(void (^ _Nullable)(BOOL successful, 
                                                            NSError * _Nullable error, 
                                                            CDYelpDetailedBusiness * _Nullable business))block;
```

#### [Phone Search API](https://www.yelp.com/developers/documentation/v2/phone_search)

```objective-c
- (void)searchYelpBusinessesWithPhoneNumber:(NSString * _Nonnull)phoneNumber                    // Required
                              byCountryCode:(NSString * _Nullable)countryCode                   // Optional
                             withCategories:(NSArray * _Nullable)categories                     // Optional
                            completionBlock:(void (^ _Nullable)(BOOL successful, 
                                                                NSError * _Nullable error, 
                                                                CDYelpSearchResults * _Nullable results))block;
```

### [DeepLink](https://www.yelp.com/developers/documentation/v2/iphone) Usage

---

## Author

Christopher de Haan, chrisdhaan@gmail.com

## Resources

Visit the [Yelp Developers](https://www.yelp.com/developers) portal for additional resources regarding the Yelp API.

## License

CDYelpKit is available under the MIT license. See the LICENSE file for more info.
