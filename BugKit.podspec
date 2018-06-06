Pod::Spec.new do |s|
s.name        = 'BugKit'
s.version     = '4.0.0'
s.authors     = { 'MrLujh' => '287929070@qq.com' }
s.homepage    = 'https://github.com/MrLujh/BugKit'
s.summary     = 'Very useful built-in tools'
s.source      = { :git => 'https://github.com/MrLujh/BugKit.git',
:tag => s.version.to_s }
s.license     = { :type => "MIT", :file => "LICENSE" }
s.platform = :ios, '7.0'
s.requires_arc = true
s.public_header_files = 'BugKit/BugKit.h'
s.source_files = 'BugKit/BugKit.h'
s.ios.deployment_target = '7.0'
s.dependency 'FLEX'
s.dependency 'CocoaLumberjack'

s.subspec 'ShakeWindow' do |ss|

    ss.public_header_files = 'ShakeWindow/*.h'
    ss.source_files = 'ShakeWindow'
   
  end

s.subspec 'LogInfo' do |ss|

    ss.public_header_files = 'LogInfo/*.h'
    ss.source_files = 'LogInfo'
   
  end

s.subspec 'BaseUrl' do |ss|

    ss.public_header_files = 'BaseUrl/*.h'
    ss.source_files = 'BaseUrl'
   
  end

s.subspec 'AppDownLoad' do |ss|

    ss.public_header_files = 'AppDownLoad/*.h'
    ss.source_files = 'AppDownLoad'
   
  end

s.subspec 'SystemState' do |ss|

    ss.public_header_files = 'SystemState/*.h'
    ss.source_files = 'SystemState'
   
  end
end
