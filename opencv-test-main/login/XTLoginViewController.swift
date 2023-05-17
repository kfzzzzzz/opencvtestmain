//
//  XTLoginViewController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 4/12/23.
//

import UIKit
import SnapKit
import Amplify
import NVActivityIndicatorView

class XTLoginViewController : UIViewController {
    
    private lazy var activityIndicatorView : NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(frame: CGRectMake(UIScreen.main.bounds.width*0.1, UIScreen.main.bounds.height*0.1,         UIScreen.main.bounds.width*0.8,UIScreen.main.bounds.height*0.4), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.pink1(),padding: 120.atScale())
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MainTabIcon")
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var phoneNumberField: ATPhoneNumberTextField = {
        let textField = ATPhoneNumberTextField.init(frame: .zero)
        textField.placeholder = "请输入手机号 ..."
        textField.textContentType = .telephoneNumber
        
        self.view.addSubview(textField)
        return textField
    } ()
    
    
    private lazy var passwordField: ATRoundRectTextField = {
        let textField = ATRoundRectTextField.init(frame: .zero)
        textField.keyboardType = .asciiCapable
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.placeholder = "请输入密码 ..."
        
        self.view.addSubview(textField)
        return textField
    } ()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("登录", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.pink1()
        button.layer.cornerRadius = 18.atScale()
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)   
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("暂无账号？前往注册", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.pink2(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.addTarget(self, action: #selector(gotoRegister), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserInfoRefresh), name: Notification.Name.updateUserData, object: nil)
        
        logoImageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(scalePadSize(100.atScale(), withPhoneSize: 100.atScale()))
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50.atScale())
        }
        phoneNumberField.snp.makeConstraints{ make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20.atScale())
            make.height.equalTo(50.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
        passwordField.snp.makeConstraints{ make in
            make.top.equalTo(phoneNumberField.snp.bottom).offset(20.atScale())
            make.height.equalTo(50.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
        loginButton.snp.makeConstraints{ make in
            make.top.equalTo(passwordField.snp.bottom).offset(20.atScale())
            make.height.equalTo(50.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
        registerButton.snp.makeConstraints{ make in
            make.top.equalTo(loginButton.snp.bottom).offset(20.atScale())
            make.height.equalTo(20.atScale())
            make.centerX.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          tapGesture.cancelsTouchesInView = false
          view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleUserInfoRefresh(){
        //AccountManager.shared.signInUserModelCheck {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                if UserData.shared.isSignedIn {
                    self.navigationController?.popViewController(animated: true)
                    let MainTabBarController = MainTabBarController()
                    self.navigationController?.pushViewController(MainTabBarController, animated: true)
                }
            }
        //}
    }
    
    @objc private func loginButtonTapped(){
        phoneNumberField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let phoneNumber = phoneNumberField.text, let password = passwordField.text, !phoneNumber.isEmpty, !password.isEmpty else{
            self.view.makeToast("气死了，有没有正确输入账号密码啊！")
            return
        }
        
        activityIndicatorView.startAnimating()
        
        Amplify.Auth.signIn(username: "+86" + phoneNumber, password: password) { result in
            switch result {
            case .success:
                print("成功登录\(UserData.shared.userPhoneNumber)")
                self.checkConfirmed()
            case .failure(let error):
                print("登录失败 \(error)")
                DispatchQueue.main.async {
                    self.view.makeToast("气死了，登录失败请检查账号和网络！")
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
    
    func checkConfirmed(){
        let delayTime = DispatchTime.now() + 60.0
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            if self.activityIndicatorView.isAnimating == true{
                self.activityIndicatorView.stopAnimating()
                self.view.makeToast("登录失败，请检查账号是否激活或者联系KFZ")
            }
        }
    }
    
    @objc func gotoRegister(){
        let vc = XTRegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    @objc func onTextChanged(_ notification: Notification) {
//        let phoneNumber = self.phoneNumberField.text ?? ""
//        let otherText = self.passwordField.text ?? ""
//
//        if phoneNumber.isEmpty || otherText.isEmpty {
//            self.loginButton.isEnabled = false
//        }
//        else {
//            self.loginButton.isEnabled = true
//        }
//    }
    
}
