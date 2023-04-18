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
        //imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(gesture)
        self.view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var phoneNumberField: ATPhoneNumberTextField = {
        let textField = ATPhoneNumberTextField.init(frame: .zero)
        let attribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16) as Any,
                                                         NSAttributedString.Key.foregroundColor: UIColor.black as Any]
        textField.attributedPlaceholder = NSAttributedString.init(string: "输入手机号", attributes: attribute)
        textField.textContentType = .telephoneNumber
        
        self.view.addSubview(textField)
        return textField
    } ()
    
    private lazy var nameField : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none  //自动大写样式
        field.autocorrectionType = .no //自动更正样式
        field.returnKeyType = .continue //返回键可视
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "LastName Address ..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        self.view.addSubview(field)
        return field
    }()
    
    private lazy var emailField : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none  //自动大写样式
        field.autocorrectionType = .no //自动更正样式
        field.returnKeyType = .continue //返回键可视
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address ..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        self.view.addSubview(field)
        return field
    }()
    
    
    private lazy var passwordField : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none  //自动大写样式
        field.autocorrectionType = .no //自动更正样式
        field.returnKeyType = .done //返回键可视
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password ..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        self.view.addSubview(field)
        return field
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
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
        button.setTitleColor(.blue, for: .normal)
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
            make.width.height.equalTo(scalePadSize(50, withPhoneSize: 50))
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30.atScale())
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
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(200.atScale())
            make.left.equalToSuperview().offset(20.atScale())
            make.right.equalToSuperview().offset(-20.atScale())
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

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
            print("nonononono")
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

