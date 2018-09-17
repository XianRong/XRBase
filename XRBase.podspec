
Pod::Spec.new do |s|
  s.name             = 'XRBase'
  s.version          = '0.1.1'
  s.summary          = 'XRBase.'

  s.description      = <<-DESC
分类、工具类等组成的基础组件
                       DESC

  s.homepage         = 'https://github.com/XianRong/XRBase'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yhtyhrt6@qq.com' => 'yhtyhrt6@qq.com' }
  s.source           = { :git => 'https://github.com/XianRong/XRBase.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'XRBase/Classes/**/*'
  
   s.resource_bundles = {
     'XRBase' => ['XRBase/Assets/*.png']
   }

  # s.public_header_files = 'Pod/Classes/**/.h'
  
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  
end
