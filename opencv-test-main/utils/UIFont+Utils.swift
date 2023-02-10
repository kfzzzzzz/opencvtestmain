//
//  UIFont+Utils.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/10/23.
//

import UIKit

//华康楷体 W5
fileprivate let SmileySansName: String = "SmileySans-Oblique"

extension UIFont {
    @objc public static func SmileySans(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: SmileySansName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
