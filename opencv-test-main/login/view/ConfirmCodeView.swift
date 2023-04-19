//
//  ConfirmCodeView.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 4/18/23.
//

import Foundation
import SnapKit
import UIKit

class ConfirmCodeView : UIView {
    
    var userPhoneNumber : String?
    
    private lazy var bgView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15.atScale()
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var noticeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.PFRegular(12.atScale())
        label.textColor = UIColor.black
        label.text = "请输入邮箱收到的验证码，若没有收到邮件请将账号发送至310654959@qq.com，或者微信联系K_F_Z_UUU"
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var numberField : UITextField = {
        let field = UITextField()
        field.keyboardType = .numberPad
        field.autocapitalizationType = .none  //自动大写样式
        field.autocorrectionType = .no //自动更正样式
        field.returnKeyType = .continue //返回键可视
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "请输入验证码 ..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("确认", for: .normal)
        button.backgroundColor = UIColor.pink1()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        backgroundColor = UIColor.pink2().withAlphaComponent(0.3)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        
        self.addSubview(bgView)
        bgView.addSubview(noticeLabel)
        bgView.addSubview(numberField)
        bgView.addSubview(confirmButton)
        
        bgView.snp.makeConstraints{ make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(220.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
        noticeLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
            make.top.equalToSuperview().offset(20.atScale())
            make.height.equalTo(40.atScale())
        }
        numberField.snp.makeConstraints{ make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(20.atScale())
            make.height.equalTo(50.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
        confirmButton.snp.makeConstraints{ make in
            make.top.equalTo(numberField.snp.bottom).offset(20.atScale())
            make.height.equalTo(50.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func confirmButtonTapped(){
        AccountManager.shared.confirmSignUp(for: userPhoneNumber ?? "", with: self.numberField.text ?? "") { result in
            DispatchQueue.main.async {
                if result{
                    self.makeToast("验证成功请前往登录")
                    self.removeFromSuperview()
                }else{
                    self.makeToast("验证失败请检查验证码或联系工作人员")
                }
            }
        }
    }
    
}
