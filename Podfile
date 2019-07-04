install! 'cocoapods', :deterministic_uuids => false
source 'https://github.com/CocoaPods/Specs.git'

# Uncomment this line to define a global platform for your project
platform :ios, '11.0'

# ignore all warnings from all pods
inhibit_all_warnings!

# 모든 target 에서 사용할 공용 dependency 선언
def shared_pods
    use_frameworks!

    # Network
    # pod 'Alamofire', '~> 4.8'
    # pod 'AlamofireImage', '~> 3.5'
    # pod 'Moya/RxSwift', '~> 12.0'
    # pod 'ReachabilitySwift', '~> 4.1'
    # pod 'RxReachability'

    # RX Core
    pod 'RxSwift'
    pod 'RxCocoa'

    # RX Extension
    # pod 'RxAlamofire'
    pod 'RxDataSources'
    # pod 'RxGesture'
    pod 'RxCocoaExt'
    pod 'RxSwiftUtilities'
    pod 'RxKeyboard'
    pod 'RxOptional'

    # RxAppState
    pod 'RxAppState'

    # UIArchitectures
    pod 'RIBs'
    
    # Firebase
    # pod 'Firebase/DynamicLinks'
    # pod 'Firebase/RemoteConfig'

    # Misc.
    pod 'Then'

    # Debugging
    pod 'FLEX'

end

# 각 target 별 dependency 선언
target 'architectures' do
    shared_pods
end

target 'architecturesTests' do
    use_frameworks!
    pod 'XCTAssertAutolayout'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        swift_version = '5.0'

        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = swift_version
        end
    end
end
