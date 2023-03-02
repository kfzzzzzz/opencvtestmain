//
//  UILable+Utils.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 3/1/23.
//

import Foundation
import UIKit

extension UILabel {
    /// 获得text，能够占有label多少行，使用font的lineHeight
    func calculateMaxLines(width: CGFloat) -> Int {
        let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = NSString(string: self.text ?? "")
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font as Any], context: nil)
        let lines = Int(textSize.height/charSize)
        return lines
    }
}
