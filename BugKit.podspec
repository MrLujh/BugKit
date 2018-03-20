Pod::Spec.new do |s|
s.name        = 'BugKit'
s.version     = '2.0.0'
s.authors     = { 'MrLujh' => '287929070@qq.com' }
s.homepage    = 'https://github.com/MrLujh/BugKit'
s.summary     = 'a dropdown menu for ios like wechat homepage.'
s.source      = { :git => 'https://github.com/MrLujh/BugKit.git',
:tag => s.version.to_s }
s.license     = { :type => "MIT", :file => "LICENSE" }

s.platform = :ios, '7.0'
s.requires_arc = true
s.source_files = 'BugKit/**/*.{h,m}'
s.ios.deployment_target = '7.0'
end
