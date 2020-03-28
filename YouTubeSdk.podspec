require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name                   = 'YouTubeSdk'
  s.version                = package['version']
  s.summary                = package['description']
  s.description            = package['description']
  s.homepage               = package['homepage']
  s.license                = package['license']
  s.author                 = package['author']
  s.source                 = { :git => 'https://github.com/up-inside/react-native-youtube-sdk.git', :tag => "master" }

  s.platform               = :ios, '9.0'
  s.ios.deployment_target  = '9.0'
  s.swift_version = '5.0'

  s.preserve_paths         = 'LICENSE', 'package.json'
  s.source_files           = 'ios/*.{h,m,swift}'
  s.dependency               'React'
  s.dependency               'YoutubePlayerView'
end
