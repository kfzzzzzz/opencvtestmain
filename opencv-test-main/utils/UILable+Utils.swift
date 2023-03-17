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

class PaddingLabel: UILabel {
    
    var insets = UIEdgeInsets.zero
    
    /// Добавляет отступы
    func padding(_ top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width + left + right, height: self.frame.height + top + bottom)
        insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += insets.top + insets.bottom
            contentSize.width += insets.left + insets.right
            return contentSize
        }
    }
}
