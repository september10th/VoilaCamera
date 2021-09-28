#
# Be sure to run `pod lib lint VoilaCam.podspec' to ensure this.
# VoilaCam
#
# Created by Luo Yu on 2021-09-28.
# Email: indie.luo@gmail.com
#
# The MIT License (MIT)
#
# Copyright (c) 2021 骆昱(Luo Yu). All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

Pod::Spec.new do |s|
  s.name             = 'VoilaCam'
  s.version          = '0.1.0'
  s.summary          = 'VoilaCam.'

  s.description      = <<-DESC
voila camera swift version.
                       DESC

  s.homepage         = 'https://github.com/september10th/VoilaCamera'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rick Luo' => 'indie.luo@gmail.com' }
  s.source           = { :git => 'https://github.com/september10th/VoilaCamera.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://weibo.com/blodely'

  s.ios.deployment_target = '11.0'

  s.source_files = 'VoilaCam/Classes/**/*'
  
  # s.resource_bundles = {
  #   'VoilaCam' => ['VoilaCam/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  
  s.frameworks = 'UIKit', 'AVFoundation', 'CoreImage', 'CoreVideo', 'Metal', 'CoreGraphics'
  
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.dependency 'NextLevel', '~> 0.16.5'
  s.dependency 'Player', '~> 0.13.3'
  
end
