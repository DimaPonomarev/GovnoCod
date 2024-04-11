# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ModsApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ModsApp


#  pod 'Adjust', '~> 4.33.3'
#  pod 'PushwooshXCFramework'
#  pod 'Gifu'

end

target 'NotificationService' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NotificationService

end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
         end
    end
  end
end

