#
# Be sure to run `pod lib lint CDYelpKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CDYelpKit'
  s.version          = '0.3.5'
  s.summary          = 'An extensive Objective C wrapper for the Yelp API.'
  s.description      = <<-DESC
This Objective C wrapper covers all possible network endpoints and responses for the Yelp developers API.
                       DESC

  s.homepage         = 'https://github.com/chrisdhaan/CDYelpKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Christopher de Haan' => 'chrisdhaan@gmail.com' }
  s.source           = { :git => 'https://github.com/chrisdhaan/CDYelpKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dehaan_solo'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CDYelpKit/Classes/{Core,Model,Responses}/**/*.{h,m}'

# s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreLocation'
  s.dependency 'Overcoat', '~> 4.0.0-beta.2'
  s.dependency 'BDBOAuth1Manager', '~> 2.0.0'

end
