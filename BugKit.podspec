Pod::Spec.new do |s|
s.name        = 'BugKit'
s.version     = '4.0.0'
s.authors     = { 'MrLujh' => '287929070@qq.com' }
s.homepage    = 'https://github.com/MrLujh/BugKit'
s.summary     = 'Very useful built-in tools'
s.source      = { :git => 'https://github.com/MrLujh/BugKit.git',
:tag => s.version.to_s }
s.license     = { :type => "MIT", :file => "LICENSE" }
  s.requires_arc = true
  
  s.public_header_files = 'BugKit/BugKit.h'
  s.source_files = 'BugKit/BugKit.h'
  s.dependency 'FLEX'
  s.dependency 'CocoaLumberjack'
  pch_Bu = <<-EOS
#ifndef TARGET_OS_IOS
  #define TARGET_OS_IOS TARGET_OS_IPHONE
#endif

#ifndef TARGET_OS_WATCH
  #define TARGET_OS_WATCH 0
#endif

#ifndef TARGET_OS_TV
  #define TARGET_OS_TV 0
#endif
EOS
  s.prefix_header_contents = pch_Bu
  
  s.ios.deployment_target = '7.0'
 
  
  s.subspec 'ShakeWindow' do |ss|
    ss.source_files = 'BugKit/BugKit/BugKitShakeWindow.{h,m}','BugKit/BugKit/BugkitListTableViewController.{h,m}'
    ss.public_header_files = 'BugKit/BugKit/BugKitShakeWindow.h','BugKit/BugKit/BugkitListTableViewController.h'
    
  end

  s.subspec 'LogInfo' do |ss|
    ss.source_files = 'BugKit/BugKit/BugKitLogInfoViewController.{h,m}'
    ss.public_header_files = 'BugKit/BugKit/BugKitLogInfoViewController.h'
  end

  s.subspec 'BaseUrl' do |ss|
    ss.ios.deployment_target = '7.0'
    
    ss.source_files = 'BugKit/BugKit/BugKitDataModel.{h,m}','BugKit/BugKit/BugKitSwitchBaseUrlController.{h,m}','BugKit/BugKit/BugKitBaseUrlManager.{h,m}'
    ss.public_header_files = 'BugKit/BugKit/BugKitDataModel.h','BugKit/BugKit/BugKitSwitchBaseUrlController.h','BugKit/BugKit/BugKitBaseUrlManager.h'
  end

  s.subspec 'AppDownLoad' do |ss|

    ss.dependency 'BugKit/ShakeWindow'
    ss.dependency 'BugKit/LogInfo'
    ss.dependency 'BugKit/BaseUrl' 
  
    ss.source_files = 'BugKit/BugKit/BugKitAppDownloadController.{h,m}'
    ss.public_header_files = 'BugKit/BugKit/BugKitAppDownloadController.h'
  end

  s.subspec 'SystemState' do |ss|
    ss.ios.deployment_target = '7.0'
    ss.dependency 'BugKit/AppDownLoad'

    ss.public_header_files = 'SystemState/*.h'
    ss.source_files = 'SystemState'
  end
end
