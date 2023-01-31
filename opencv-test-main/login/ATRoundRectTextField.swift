//
//  ATRoundRectTextField.swift
//  FirebaseChat
//
//  Created by 孔繁臻 on 10/8/22.
//

import UIKit

@objcMembers
class ATRoundRectTextField: UITextField {
    
    var textLeftMargin: CGFloat = 20
    var textRightMargin: CGFloat = 20
    
    var docoration: ((ATRoundRectTextField)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = UIColor.black
        self.backgroundColor = UIColor.gray
        
        self.clearButtonMode = .whileEditing
        if let clearButton = self.value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage(named:"login_clear"), for: .normal)
            clearButton.setImage(UIImage(named:"login_clear"), for: .highlighted)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
        self.docoration?(self)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect.init(x: bounds.minX + textLeftMargin, y: bounds.minY, width: bounds.width - textLeftMargin - textRightMargin - 24, height: bounds.height)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect.init(x: bounds.maxX - 22 - textRightMargin, y: (bounds.height - 22)/2, width: 22, height: 22)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        return false
    }
}

