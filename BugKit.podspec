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

s.subspec 'LogInfo' do |ss|
   
    ss.dependency 'CocoaLumberjack'

    ss.source_files = 'BugKit/LogInfo/**/*.{h,m}'
    ss.public_header_files = 'BugKit/LogInfo/**/*.h'
    
  end

s.subspec 'BaseUrl' do |ss|
    

    ss.source_files = 'BugKit/BaseUrl/**/*.{h,m}'
    ss.public_header_files = 'BugKit/BaseUrl/**/*.h'
    
  end

s.subspec 'AppDownLoad' do |ss|

    ss.dependency 'BugKit/BaseUrl'
    ss.source_files = 'BugKit/AppDownLoad/**/*.{h,m}'
    ss.public_header_files = 'BugKit/AppDownLoad/**/*.h'
    
  end

s.subspec 'SystemState' do |ss|
   
    ss.source_files = 'BugKit/SystemState/**/*.{h,m}'
    ss.public_header_files = 'BugKit/SystemState/**/*.h'
    
  end

s.subspec 'ShakeWindow' do |ss|

    ss.dependency 'FLEX'

    ss.dependency 'BugKit/LogInfo'
    ss.dependency 'BugKit/AppDownLoad'
    ss.dependency 'BugKit/SystemState'

    ss.source_files = 'BugKit/ShakeWindow/**/*.{h,m}'
    ss.public_header_files = 'BugKit/ShakeWindow/**/*.h'
    
  end


end