# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'opencv-test-main' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for opencv-test-main
  pod 'Kingfisher', '~> 4.6'
  pod 'SnapKit', '~> 5.0.0'
  pod 'DeviceKit', '4.5.1'
  pod 'ObjectMapper', '3.5.3'
  pod 'Moya', '14.0.0'
  pod 'RxSwift',    '~> 5.1.1'
  pod 'Amplify'             # required amplify dependency
  pod 'AmplifyPlugins/AWSCognitoAuthPlugin' # support for Cognito user authentication
  pod 'AmplifyPlugins/AWSAPIPlugin'         # support for GraphQL API
  pod 'AmplifyPlugins/AWSS3StoragePlugin'
  pod 'AmplifyPlugins/AWSDataStorePlugin'
  pod 'NVActivityIndicatorView'
  pod 'Toast-Swift', '~> 5.0.1'
  pod 'FLEX', :configurations => ['Debug']
  

  flutter_application_path = '../opencvtestmain/Submoudle'
  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
  
  install_all_flutter_pods(flutter_application_path)

end

post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
