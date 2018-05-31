#
# Be sure to run `pod lib lint AMCodeView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AMCodeView'
  s.version          = '0.1.0'
  s.summary          = 'Simple view for input login code'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Configurable view for input login code
                       DESC

  s.homepage         = 'https://github.com/Davarg/AMCodeView'
  s.screenshots      = 'https://raw.githubusercontent.com/Davarg/ReadmeFiles/0ca443d49f92a2e1d9bc302fed878fb59f4adbd9/AMCodeView/first.png', 'https://raw.githubusercontent.com/Davarg/ReadmeFiles/0ca443d49f92a2e1d9bc302fed878fb59f4adbd9/AMCodeView/second.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Davarg' => 'maka-dava@yandex.ru' }
  s.source           = { :git => 'https://github.com/Davarg/AMCodeView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Underbridgins'

  s.ios.deployment_target = '10.0'

  s.source_files = 'AMCodeView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AMCodeView' => ['AMCodeView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Masonry', '~> 1.1'
end
