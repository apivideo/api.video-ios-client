Pod::Spec.new do |s|
  s.name = 'ApiVideoClient'
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  # Add back when CocoaPods/CocoaPods#11558 is released
  #s.watchos.deployment_target = '3.0'
  s.version = '1.3.7'
  s.source = { :git => 'https://github.com/apivideo/api.video-swift-client', :tag => 'v1.3.7' }
  s.authors = { 'Ecosystem Team' => 'ecosystem@api.video' }
  s.license = { :type => 'MIT' }
  s.homepage = 'https://docs.api.video'
  s.summary = 'The official Swift api.video client for iOS, macOS and tvOS'
  s.source_files = 'Sources/**/*.swift'
  s.dependency 'AnyCodable-FlightSchool', '~> 0.6.1'
  s.dependency 'Alamofire', '~> 5.4.3'
end
