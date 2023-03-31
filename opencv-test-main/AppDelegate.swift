//
//  AppDelegate.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 1/15/23.
//

import UIKit
import Flutter
import FlutterPluginRegistrant


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    //lazy var flutterEngine = FlutterEngine(name: "my flutter engine")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        flutterEngine.navigationChannel.invokeMethod("setInitialRoute", arguments:"tip2")
//        flutterEngine.run();
        // Connects plugins with iOS platform code to this app.
        //GeneratedPluginRegistrant.register(with: self.flutterEngine);
        
        
        // initialize Amplify
         _ = AccountManager.shared
        _ = chatGPTManager.shared
        _ = stableDiffusionManager.shared
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    var window: UIWindow?


}

