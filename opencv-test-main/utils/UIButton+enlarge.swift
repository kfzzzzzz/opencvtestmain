//
//  UIButton+enlarge.swift
//  AthenaPhone
//
//  Created by 郝丹 on 2022/8/16.
//  Copyright © 2022 youdao. All rights reserved.
//

import Foundation
import UIKit

private var ExtendEdgeInsetsKey: Void?

extension UIButton {
    
    /// 设置此属性即可扩大响应范围, 分别对应上左下右
    /// 优势：与Auto-Layout无缝配合
    /// 劣势：View Debugger 查看不到增加的响应区域有多大，
    var extendEdgeInsets: UIEdgeInsets {
        get {
            return objc_getAssociatedObject(self, &ExtendEdgeInsetsKey) as? UIEdgeInsets ?? UIEdgeInsets.zero
        }
        set {
            objc_setAssociatedObject(self, &ExtendEdgeInsetsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if UIEdgeInsetsEqualToEdgeInsets(extendEdgeInsets, .zero) || !self.isEnabled || self.isHidden || self.alpha < 0.01 {
            return super.point(inside: point, with: event)
        }
        let newRect = extendRect(bounds, extendEdgeInsets)
        return newRect.contains(point)
    }
    
    private func extendRect(_ rect: CGRect, _ edgeInsets: UIEdgeInsets) -> CGRect {
        let x = rect.minX - edgeInsets.left
        let y = rect.minY - edgeInsets.top
        let w = rect.width + edgeInsets.left + edgeInsets.right
        let h = rect.height + edgeInsets.top + edgeInsets.bottom
        return CGRect(x: x, y: y, width: w, height: h)
    }
}
