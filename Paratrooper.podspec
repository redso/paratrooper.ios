#
# Be sure to run `pod lib lint Paratrooper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Paratrooper'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Paratrooper.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/redso/paratrooper.ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Edwin Kwok' => 'edwinkcw@redso.com.hk' }
  s.source           = { :git => 'https://github.com/redso/paratrooper.ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Paratrooper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Paratrooper' => ['Paratrooper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
