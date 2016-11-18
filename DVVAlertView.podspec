

Pod::Spec.new do |s|

s.name         = 'DVVAlertView'
s.summary      = '对UIAlertView和UIAlertController的封装，使用简单方便。'
s.version      = '1.0.0'
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.authors      = { 'devdawei' => '2549129899@qq.com' }
s.homepage     = 'https://github.com/devdawei'

s.platform     = :ios
s.ios.deployment_target = '7.0'
s.requires_arc = true

s.source       = { :git => 'https://github.com/devdawei/DVVAlertView.git', :tag => s.version.to_s }

s.source_files = 'DVVAlertView/DVVAlertView/*.{h, m}'

s.frameworks = 'Foundation', 'UIKit'

end
