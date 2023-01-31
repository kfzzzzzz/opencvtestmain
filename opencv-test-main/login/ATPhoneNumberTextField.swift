//
//  ATPhoneNumberTextField.swift
//  FirebaseChat
//
//  Created by 孔繁臻 on 10/8/22.
//

import UIKit
//import AthenaUtils

class ATPhoneNumberTextField: UITextField {
    
    public var selectCountryCode: (() -> Void)? = nil
    
    public var countryCode: String {
        get {
            return self.areaCodeButton.title(for: .normal) ?? ""
        }
        set {
            self.areaCodeButton.setTitle(newValue, for: .normal)
        }
    }
    
    private lazy var areaCodeButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("+86", for: .normal)
//        button.setTitleColor(UIColor.atCt1(), for: .normal)
//        button.titleLabel?.font = UIFont.pingFangSemiboldFont(ofSize: kUIFontSize16)
        button.addTarget(self, action: #selector(selectCountry), for: .touchUpInside)
        button.setImage(UIImage(named: "login_country_code"), for: .normal)
        button.backgroundColor = UIColor.clear
        
        self.addSubview(button)
        return button
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = UIColor.black
        self.backgroundColor = UIColor.gray
        self.textAlignment = .left
        self.keyboardType = .numberPad
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
        
        self.areaCodeButton.frame = CGRect.init(x: 0, y: 12, width: 72, height: 25)
        self.areaCodeButton.imageEdgeInsets = UIEdgeInsets.init(top: 7, left: self.areaCodeButton.frame.size.width - 11, bottom: 7, right: 0)
        self.areaCodeButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 11)
    }
    
    @objc func selectCountry() {
        self.selectCountryCode?()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect.init(x: bounds.minX + 82, y: bounds.minY + 1, width: bounds.width - 132, height: bounds.height - 1)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect.init(x: bounds.maxX - 42, y: (bounds.height - 22)/2, width: 22, height: 22)
    }
}

