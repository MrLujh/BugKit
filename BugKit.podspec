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


s.subspec 'ShakeWindow' do |ss|
    ss.source_files = 'BugKit/ShakeWindow/BugKitShakeWindow.{h,m}','BugKit/ShakeWindow/BugkitListTableViewController.{h,m}'
    ss.public_header_files = 'BugKit/ShakeWindow/BugKitShakeWindow.h','BugKit/ShakeWindow/BugkitListTableViewController.h'
   
    ss.dependency 'FLEX'
  end

  s.subspec 'LogInfo' do |ss|
    ss.source_files = 'BugKit/LogInfo/BugKitLogInfoViewController.{h,m}'
    ss.public_header_files = 'BugKit/LogInfo/BugKitLogInfoViewController.h'
    ss.dependency 'CocoaLumberjack'
  end

  s.subspec 'BaseUrl' do |ss|
    ss.source_files = 'BugKit/BaseUrl/BugKitDataModel.{h,m}','BugKit/BaseUrl/BugKitSwitchBaseUrlController.{h,m}','BugKit/BaseUrl/BugKitBaseUrlManager.{h,m}'
    ss.public_header_files = 'BugKit/BaseUrl/BugKitDataModel.h','BugKit/BaseUrl/BugKitSwitchBaseUrlController.h','BugKit/BaseUrl/BugKitBaseUrlManager.h'
  end

  s.subspec 'AppDownLoad' do |ss|
    ss.dependency 'BugKit/ShakeWindow'
    ss.dependency 'BugKit/LogInfo'
    ss.dependency 'BugKit/BaseUrl'

    ss.source_files = 'BugKit/AppDownLoad/BugKitAppDownloadController.{h,m}'
    ss.public_header_files = 'BugKit/AppDownLoad/BugKitAppDownloadController.h'
  end

  s.subspec 'SystemState' do |ss|
    ss.ios.deployment_target = '7.0'
    ss.dependency 'BugKit/SystemState'

    ss.public_header_files = 'SystemState/*.h'
    ss.source_files = 'SystemState'
  end
end
