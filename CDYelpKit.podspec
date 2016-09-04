#
# Be sure to run `pod lib lint CDYelpKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CDYelpKit'
  s.version          = '0.9.7'
  s.summary          = 'An extensive Objective C wrapper for the Yelp Developers V2 API.'
  s.description      = <<-DESC
This Objective C wrapper covers all possible network endpoints and responses for the Yelp Developers V2 API.
                       DESC
  s.homepage         = 'https://github.com/chrisdhaan/CDYelpKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Christopher de Haan' => 'contact@christopherdehaan.me' }
  s.source           = { :git => 'https://github.com/chrisdhaan/CDYelpKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dehaan_solo'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.subspec 'V2' do |v2|

    v2.subspec 'Core' do |core|
      core.source_files = 'CDYelpKit/Classes/V2/Core/{Headers,Request,Response,**}/{Model,**}/**/*.{h,m}'
      core.frameworks = 'CoreLocation', 'MapKit'
      core.dependency 'Overcoat', '~> 4.0.0-beta.2'
      core.dependency 'CDYelpKit/V2/OAuth'
    end

    v2.subspec 'OAuth' do |oauth|
      oauth.source_files = 'CDYelpKit/Classes/V2/OAuth/**/*.{h,m}'
      oauth.dependency 'CDOAuth1Kit'
    end

    v2.subspec 'DeepLink' do |deeplink|
      deeplink.source_files = 'CDYelpKit/Classes/V2/DeepLink/**/*.{h,m}'
    end

  end
end
