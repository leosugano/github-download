platform :ios, '13.0'
use_frameworks!

# ignore all warnings from all dependencies
inhibit_all_warnings!
# ignore warnings from a specific dependency

target 'Github' do
  pod 'Alamofire'
  pod 'SnapKit'
  pod 'SwiftLint'
  pod 'SwiftGen', '~> 6.0'
end

target 'GithubTests' do
  pod 'Quick'
  pod 'Nimble'
  pod 'SnapshotTesting', '~> 1.8.1'

end

post_install do |installer|
 installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
        config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
        config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
        config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 13.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
     end
 end
end
