//
//  UIFont+Utils.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/10/23.
//

import UIKit

//得意黑
fileprivate let SmileySansName: String = "SmileySans-Oblique"

//苹方
fileprivate let PingFangSCSemibold : String = "PingFangSC-Semibold"
fileprivate let PingFangSCRegular : String  = "PingFangSC-Regular"

extension UIFont {
    
    @objc public static func SmileySans(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: SmileySansName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    @objc public static func PFSemibold(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: PingFangSCSemibold, size: size) ??
        UIFont.systemFont(ofSize: size)
    }
    
    @objc public static func PFRegular(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: PingFangSCRegular, size: size) ??
        UIFont.systemFont(ofSize: size)
    }
}
