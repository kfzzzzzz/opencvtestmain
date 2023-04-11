//
//  AppDelegate.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 1/15/23.
//

import UIKit
import Flutter
import FlutterPluginRegistrant
import flutter_boost


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // initialize Amplify
         _ = AccountManager.shared
        _ = chatGPTManager.shared
        
        //创建代理，做初始化操作
        let delegate = BoostDelegate()
        FlutterBoost.instance().setup(application, delegate: delegate) { engine in
            FlutterMessageManager.shared.engine = engine
            FlutterMessageManager.shared.handleMessage()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    var window: UIWindow?
}

