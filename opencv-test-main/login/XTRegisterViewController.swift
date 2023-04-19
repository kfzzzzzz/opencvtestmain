//
//  XTRegisterViewController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 4/18/23.
//

import UIKit
import SnapKit
import Amplify

class XTRegisterViewController: UIViewController {
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MainTabIcon")
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        return imageView
    }()
    
//    private lazy var imageView : UIImageView = {
//        let imageView = UIImageView()
//        //imageView.image = UIImage(systemName: "person.circle")
//        imageView.tintColor = .gray
//        imageView.contentMode = .scaleAspectFit
//        imageView.layer.masksToBounds = true
//        imageView.layer.borderWidth = 2
//        imageView.layer.borderColor = UIColor.lightGray.cgColor
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
//        imageView.addGestureRecognizer(gesture)
//        self.view.addSubview(imageView)
//        return imageView
//    }()
    
    private lazy var phoneNumberField: ATPhoneNumberTextField = {
        let textField = ATPhoneNumberTextField.init(frame: .zero)
        textField.placeholder = "请输入手机号（每个手机号唯一） ..."
        textField.textContentType = .telephoneNumber
        
        self.view.addSubview(textField)
        return textField
    } ()
    
    private lazy var nameField : ATRoundRectTextField = {
        let field = ATRoundRectTextField.init(frame: .zero)
        field.autocapitalizationType = .none  //自动大写样式
        field.autocorrectionType = .no //自动更正样式
        field.returnKeyType = .continue //返回键可视
        field.placeholder = "请输入用户名 ..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        self.view.addSubview(field)
        return field
    }()
    
    private lazy var emailField : ATRoundRectTextField = {
        let field = ATRoundRectTextField.init(frame: .zero)
        field.autocapitalizationType = .none  //自动大写样式
        field.autocorrectionType = .no //自动更正样式
        field.returnKeyType = .continue //返回键可视
        field.placeholder = "请输入邮箱地址（用于接受验证码）..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        self.view.addSubview(field)
        return field
    }()
    
    
    private lazy var passwordField : ATRoundRectTextField = {
        let field = ATRoundRectTextField.init(frame: .zero)
        field.autocapitalizationType = .none  //自动大写样式
        field.autocorrectionType = .no //自动更正样式
        field.returnKeyType = .done //返回键可视
        field.placeholder = "请输入密码 ..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        self.view.addSubview(field)
        return field
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("注册", for: .normal)
        button.backgroundColor = UIColor.pink1()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 18.atScale()
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("已有账号？返回登录", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.pink2(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(gotoLogin), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var confirmView : ConfirmCodeView = {
        let view = ConfirmCodeView()
        view.isHidden = true
        self.view.addSubview(view)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        phoneNumberField.delegate = self
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        imageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(scalePadSize(100.atScale(), withPhoneSize: 100.atScale()))
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50.atScale())
        }
        phoneNumberField.snp.makeConstraints{ make in
            make.top.equalTo(imageView.snp.bottom).offset(20.atScale())
            make.height.equalTo(50.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
        nameField.snp.makeConstraints{ make in
            make.top.equalTo(phoneNumberField.snp.bottom).offset(20.atScale())
            make.height.equalTo(50.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
        emailField.snp.makeConstraints{ make in
            make.top.equalTo(nameField.snp.bottom).offset(20.atScale())
            make.height.equalTo(50.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
        passwordField.snp.makeConstraints{ make in
            make.top.equalTo(emailField.snp.bottom).offset(20.atScale())
            make.height.equalTo(50.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
        registerButton.snp.makeConstraints{ make in
            make.top.equalTo(passwordField.snp.bottom).offset(20.atScale())
            make.height.equalTo(50.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
        loginButton.snp.makeConstraints{ make in
            make.top.equalTo(registerButton.snp.bottom).offset(20.atScale())
            make.height.equalTo(20.atScale())
            make.centerX.equalToSuperview()
        }
        confirmView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          tapGesture.cancelsTouchesInView = false
          view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func imageViewTapped(){
        print("imageViewTapped")
        presentPhotoActionSheet()
    }
    
    @objc private func gotoLogin(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func registerButtonTapped(){
        phoneNumberField.resignFirstResponder()
        nameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard var phoneNumber = phoneNumberField.text, let name = nameField.text, let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty,!phoneNumber.isEmpty,!name.isEmpty else{
            self.view.makeToast("请将信息填写完毕！")
            return
        }
        
        phoneNumber = "+86" + phoneNumber
        confirmView.userPhoneNumber = phoneNumber
        
        let userAttributes = [AuthUserAttribute(.email, value: email), AuthUserAttribute(.phoneNumber, value: phoneNumber), AuthUserAttribute(.name, value: name)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: phoneNumber, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    DispatchQueue.main.async {
                        self.confirmView.isHidden = false
                    }
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
                DispatchQueue.main.async {
                    if String(describing: error).contains("usernameExists") {
                        self.view.makeToast("账号已存在")
                    } else {
                        self.view.makeToast(String(describing: error))
                    }
                }
            }
        }

        
    }
    
//    func alerUserLoginError(message: String = "Plase enter all information"){
//        let alert = UIAlertController(title: "woops", message: message, preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
//        present(alert,animated: true)
//    }
    
//    @objc private func didTapRegister(){
//        let vc = RegisterViewController()
//        //vc.title = "Cteate Account"
//        navigationController?.pushViewController(vc, animated: true)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension XTRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneNumberField {
            nameField.becomeFirstResponder()
        }
        if textField == nameField {
            emailField.becomeFirstResponder()
        }
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        if textField == passwordField {
            registerButtonTapped()
        }
        return true
    }
}

extension XTRegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile picture", message: "How would likt to select a picture?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: {[weak self] _ in self?.presentCamera()}))
        actionSheet.addAction(UIAlertAction(title: "Chose photo", style: .default, handler: {[weak self] _ in self?.presentPhotoPicker()}))
        
        present(actionSheet,animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = . photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated:true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print(info)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        
        self.imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

