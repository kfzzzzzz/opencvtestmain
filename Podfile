# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'opencv-test-main' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for opencv-test-main
  pod 'SnapKit', '~> 5.0.0'
  pod 'DeviceKit', '4.5.1'
  pod 'ObjectMapper', '3.5.3'
  pod 'Moya', '14.0.0'
  pod 'RxSwift',    '~> 5.1.1'
  pod 'Amplify', '~> 1.0'             # required amplify dependency
  pod 'Amplify/Tools', '~> 1.0'       # allows to call amplify CLI from within Xcode
#  pod 'AmplifyPlugins/AWSCognitoAuthPlugin', '~> 1.0' # support for Cognito user authentication
#  pod 'AmplifyPlugins/AWSAPIPlugin', '~> 1.0'         # support for GraphQL API
#  pod 'AmplifyPlugins/AWSS3StoragePlugin', '~> 1.0'   # support for Amazon S3 storage

  flutter_application_path = '../opencv_flutter'
  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
  
  install_all_flutter_pods(flutter_application_path)

end

post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
