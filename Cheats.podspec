Pod::Spec.new do |s|
  s.name             = 'Cheats'
  s.version          = '1.0.0'
  s.swift_version    = '4.2'
  s.summary          = 'Retro cheat codes for modern iOS apps.'
  s.description      = <<-DESC
Allows developers to implement retro style cheat codes like the Konami code consisting of swipes and key presses.
                       DESC
  s.homepage         = 'https://github.com/rwbutler/Cheats'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rwbutler' => 'github@rwbutler.com' }
  s.source           = { :git => 'https://github.com/rwbutler/Cheats.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ross_w_butler'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Cheats/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Cheats' => ['Cheats/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
