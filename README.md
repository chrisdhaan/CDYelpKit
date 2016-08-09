# CDYelpKit

[![CI Status](http://img.shields.io/travis/chrisdhaan/CDYelpKit.svg?style=flat)](https://travis-ci.org/chrisdhaan/CDYelpKit)
[![Version](https://img.shields.io/cocoapods/v/CDYelpKit.svg?style=flat)](http://cocoapods.org/pods/CDYelpKit)
[![License](https://img.shields.io/cocoapods/l/CDYelpKit.svg?style=flat)](http://cocoapods.org/pods/CDYelpKit)
[![Platform](https://img.shields.io/cocoapods/p/CDYelpKit.svg?style=flat)](http://cocoapods.org/pods/CDYelpKit)

This pod is currently in development. As of release 0.9.0 the code is stable and in a usable state to install in applications.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iosSDK: 8.0

[Yelp API Access](https://www.yelp.com/developers/manage_api_keys)

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

## Usage

### [OAuth](https://www.yelp.com/developers/documentation/v2/authentication) Usage

#### Initialization

### Core Usage

#### Initialization

#### [Search API](https://www.yelp.com/developers/documentation/v2/search_api)

#### [Business API](https://www.yelp.com/developers/documentation/v2/business)

#### [Phone Search API](https://www.yelp.com/developers/documentation/v2/phone_search)

### [DeepLink](https://www.yelp.com/developers/documentation/v2/iphone) Usage

## Author

Christopher de Haan, chrisdhaan@gmail.com

## Resources

Visit the [Yelp Developers](https://www.yelp.com/developers) portal for additional resources regarding the Yelp API.

## License

CDYelpKit is available under the MIT license. See the LICENSE file for more info.
