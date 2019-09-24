# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'Trackd' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Trackd
  pod 'BuddyBuildSDK'
  pod 'IQKeyboardManagerSwift'
  pod 'AASegmentedControl'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'ProgressHUD'
  pod 'SDWebImage'
  pod 'SwiftyJWT'
  pod 'ReachabilitySwift'
  pod 'AudioKit'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if target.name == 'AASegmentedControl'
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end
