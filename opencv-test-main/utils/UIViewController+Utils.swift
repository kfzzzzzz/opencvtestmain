//
//  UIViewController+Utils.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/28/23.
//

import Foundation
import UIKit

extension UIViewController {

//    class func findBestViewController(vc:UIViewController!) -> UIViewController! {
//
//        if (vc.presentedViewController != nil) {
//
//            // Return presented view controller
//            return UIViewController.findBestViewController(vc: vc.presentedViewController)
//
//        } else if (vc is UISplitViewController) {
//
//            // Return right hand side
//            let svc:UISplitViewController! = vc as! UISplitViewController
//            if svc.viewControllers.count > 0
//            {return UIViewController.findBestViewController(vc: svc.viewControllers.lastObject)}
//            else
//                {return vc}
//
//        } else if (vc is UINavigationController) {
//
//            // Return top view
//            let nvc:UINavigationController! = vc as! UINavigationController
//            if nvc.viewControllers.count > 0
//            {return UIViewController.findBestViewController(vc: nvc.topViewController)}
//            else
//                {return vc}
//
//        } else if (vc is UITabBarController) {
//
//            // Return visible view
//            let svc:UITabBarController! = vc as! UITabBarController
//            if svc.viewControllers!.count > 0
//            {return UIViewController.findBestViewController(vc: svc.selectedViewController)}
//            else
//                {return vc}
//
//        } else {
//
//            // Unknown view controller type, return last child view controller
//            return vc
//        }
//    }
//
//    class func currentViewController() -> UIViewController! {
//        let viewController:UIViewController! = UIApplication.shared.keyWindow?.rootViewController
//        return UIViewController.findBestViewController(vc: viewController)
//
//    }
//
//    class func currentViewControllerSpecifyWindow(window:UIWindow!) -> UIViewController! {
//        let viewController:UIViewController! = window.rootViewController
//        return UIViewController.findBestViewController(vc: viewController)
//    }
    
    /// 返回当前的View Controller
    ///
    /// - Parameter base: 迭代起点
    /// - Returns: 当前的View Controller
    class func getCurrentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getCurrentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return getCurrentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return getCurrentViewController(base: presented)
        }
        return base
    }
}
