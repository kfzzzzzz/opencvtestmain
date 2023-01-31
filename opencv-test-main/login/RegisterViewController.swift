//
//  RegisterViewController.swift
//  FirebaseChat
//
//  Created by 孔繁臻 on 7/20/22.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
    //private let spinner = JGProgressHUD(style: .dark)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
   // spinner.show(in: view)
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let FirstNameField : UITextField = {
        let field = UITextField()
        field.textContentType = .username
        field.autocapitalizationType = .none  //自动大写样式
        field.autocorrectionType = .no //自动更正样式
        field.returnKeyType = .continue //返回键可视
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "FirstName Address ..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let LastNameField : UITextField = {
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
        return field
    }()
    
    private let emailField : UITextField = {
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
        return field
    }()
    
    
    private let passwordField : UITextField = {
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
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Acount"
        view.backgroundColor = .white
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        
        //Add target
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        //修改return属性
        FirstNameField.delegate = self
        LastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(FirstNameField)
        scrollView.addSubview(LastNameField)
        
        scrollView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        
        //Add Gesture
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let Size = scrollView.frame.size.width/3
        imageView.frame = CGRect(x: (scrollView.frame.size.width-Size)/2, y: 20, width: Size, height: Size)
        imageView.layer.cornerRadius = imageView.frame.size.width/2.0
        FirstNameField.frame = CGRect(x: 30, y: imageView.frame.size.height + imageView.frame.origin.y+10, width: scrollView.frame.size.width-60, height: 52)
        LastNameField.frame = CGRect(x: 30, y: FirstNameField.frame.size.height + FirstNameField.frame.origin.y+10, width: scrollView.frame.size.width-60, height: 52)
        emailField.frame = CGRect(x: 30, y: LastNameField.frame.size.height + LastNameField.frame.origin.y+10, width: scrollView.frame.size.width-60, height: 52)
        passwordField.frame = CGRect(x: 30, y: emailField.frame.size.height + emailField.frame.origin.y+10, width: scrollView.frame.size.width-60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passwordField.frame.size.height + passwordField.frame.origin.y+10, width: scrollView.frame.size.width-60, height: 52)
    }
    
    @objc private func imageViewTapped(){
        print("imageViewTapped")
        presentPhotoActionSheet()
    }
    
    @objc private func loginButtonTapped(){
        FirstNameField.resignFirstResponder()
        LastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let FirstName = FirstNameField.text, let LastName = LastNameField.text, let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty,!LastName.isEmpty,!FirstName.isEmpty else{
            alerUserLoginError()
            return
        }
        

        // Firebase Log In

        
    }
    
    func alerUserLoginError(message: String = "Plase enter all information"){
        let alert = UIAlertController(title: "woops", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert,animated: true)
    }
    
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

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == FirstNameField {
            LastNameField.becomeFirstResponder()
        }
        if textField == LastNameField {
            emailField.becomeFirstResponder()
        }
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        if textField == passwordField {
            loginButtonTapped()
        }
        return true
    }
}

extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
