#
# Created by Luo Yu(blodely), indie.luo@gmail.com
# Wednesday, April 10, 2019
#

Pod::Spec.new do |s|
  s.name             = 'VoilaCamera'
  s.version          = '1.1.0'
  s.summary          = 'Voilà: The Camera.'

  s.description      = <<-DESC
An open source camera app project based on GPUImage and FastttCamera.
                       DESC

  s.homepage         = 'https://github.com/september10th/VoilaCamera'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'blodely' => 'indie.luo@gmail.com' }
  s.source           = { :git => 'https://github.com/blodely/VoilaCamera.git', :tag => s.version.to_s }
  s.social_media_url = 'https://weibo.com/blodely'

  s.ios.deployment_target = '12.0'

  s.source_files = 'VoilaCamera/Classes/**/*'
  
  # s.resource_bundles = {
  #   'VoilaCamera' => ['VoilaCamera/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  
  s.frameworks = 'UIKit', 'AVFoundation', 'SceneKit', 'ARKit'
  
  s.dependency 'LYCategory', '~> 1.13'
  s.dependency 'PBJVision'
#  s.dependency 'Masonry'
  
end
