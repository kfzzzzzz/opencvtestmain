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
    
    // MARK: UISceneSession Lifecycle
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // initialize Amplify
        _ = AccountManager.shared
        _ = chatGPTManager.shared
        _ = UserData.shared
        
        //创建代理，做初始化操作
        let delegate = BoostDelegate()
        FlutterBoost.instance().setup(application, delegate: delegate) { engine in
            FlutterMessageManager.shared.engine = engine
            FlutterMessageManager.shared.handleMessage()
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            AccountManager.shared.fetchAuthSession { isSignedIn in
                var rootViewController: UIViewController?
                DispatchQueue.main.async {
                    if isSignedIn {
                        rootViewController = MainTabBarController()
                    } else {
                        rootViewController = XTLoginViewController()
                    }
                    let navigationController = UINavigationController(rootViewController: rootViewController!)
                    navigationController.isNavigationBarHidden = true
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = navigationController
                    self.window?.makeKeyAndVisible()
                }
            }
        }
        
        return true
    }
}

