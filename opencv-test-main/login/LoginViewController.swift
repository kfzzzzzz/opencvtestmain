//
//  LoginViewController.swift
//  FirebaseChat
//
//  Created by 孔繁臻 on 7/20/22.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        
        
        //imageView.image =
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var emailField: ATPhoneNumberTextField = {
        let textField = ATPhoneNumberTextField.init(frame: .zero)
        let attribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16) as Any,
                                                         NSAttributedString.Key.foregroundColor: UIColor.black as Any]
        textField.attributedPlaceholder = NSAttributedString.init(string: "输入手机号", attributes: attribute)
        textField.textContentType = .telephoneNumber
        textField.selectCountryCode = {[weak self] () in
            guard let self = self else {
                return
            }
            
            self.openCountryCode()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(onTextChanged(_:)), name: UITextField.textDidChangeNotification, object: textField)
        
       // self.addSubview(textField)
        return textField
    } ()
    
    
    private lazy var passwordField: ATRoundRectTextField = {
        let textField = ATRoundRectTextField.init(frame: .zero)
        textField.keyboardType = .asciiCapable
        if #available(iOS 12.0, *) {
            textField.textContentType = .oneTimeCode
        }
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        let attribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)as Any,
                                                         NSAttributedString.Key.foregroundColor: UIColor.black as Any]
        textField.attributedPlaceholder = NSAttributedString.init(string: "输入密码", attributes: attribute)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onTextChanged(_:)), name: UITextField.textDidChangeNotification, object: textField)
        
      //  self.addSubview(textField)
        return textField
    } ()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private var loginOberver: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        
        //Add target
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
       // FacebookloginButton.delegate = self
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        
        scrollView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true

       // scrollView.addSubview(FacebookloginButton)
        //scrollView.addSubview(googleLoginButton)
        
        //Add Gesture
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(gesture)
    }
    
    deinit{
        if let observer = loginOberver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let Size = scrollView.frame.size.width/3
        imageView.frame = CGRect(x: (scrollView.frame.size.width-Size)/2, y: 20, width: Size, height: Size)
        emailField.frame = CGRect(x: 30, y: imageView.frame.size.height + imageView.frame.origin.y+10, width: scrollView.frame.size.width-60, height: 52)
        passwordField.frame = CGRect(x: 30, y: emailField.frame.size.height + emailField.frame.origin.y+10, width: scrollView.frame.size.width-60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passwordField.frame.size.height + passwordField.frame.origin.y+10, width: scrollView.frame.size.width-60, height: 52)
        //FacebookloginButton.frame = CGRect(x: 30, y: loginButton.bottom+10, width: scrollView.width-60, height: 52)
       // FacebookloginButton.frame.origin.y = loginButton.bottom + 20
        //googleLoginButton.frame = CGRect(x: 30, y: FacebookloginButton.bottom+10, width: scrollView.width-60, height: 52)
    }
    
    @objc private func imageViewTapped(){
        print("imageViewTapped")
        print("KFZTEST:UserData.shared.isSignedIn:\(UserData.shared.isSignedIn)")
    }
    
    @objc private func loginButtonTapped(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        AccountManager.shared.signIn(username: "+8619859253270", password: "zz88718259")
//
//        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty else{
//            alerUserLoginError()
//            return
//        }
        
        //spinner.show(in: view)
        
//        if UserData.shared.isSignedIn == false{
//            AccountManager.shared.signIn()
//        }else{
//            AccountManager.shared.signOut()
//        }
        
        //Firebase Log In
//        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion:{ [weak self] authResult, error in
//            DispatchQueue.main.async {
//                self?.spinner.dismiss()
//            }
//            guard let result = authResult, error == nil else{
//            print("Faild to log in user with email:\(email)")
//            self?.alerUserLoginError()
//            return
//        }
//            let user = result.user
//            print("Logged In User:\(user)")
//            self?.navigationController?.dismiss(animated: true, completion: nil)
//        })
        
    }
    
    func alerUserLoginError(){
        let alert = UIAlertController(title: "woops", message: "Plase entet all information", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert,animated: true)
    }
    
    @objc private func didTapRegister(){
        let vc = RegisterViewController()
        //vc.title = "Cteate Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func openCountryCode() {
    }
    
    
    @objc func onTextChanged(_ notification: Notification) {
        let phoneNumber = self.emailField.text ?? ""
        let otherText = self.passwordField.text ?? ""
        
        if phoneNumber.isEmpty || otherText.isEmpty {
            self.loginButton.isEnabled = false
            //self.loginButton.backgroundColor = UIColor.atCmh1()
        }
        else {
            self.loginButton.isEnabled = true
            //self.loginButton.backgroundColor = UIColor.atCm1()
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            loginButtonTapped()
        }
        return true
    }
}

//extension LoginViewController: LoginButtonDelegate{
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//        //no operation
//    }

//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        guard let token = result?.token?.tokenString else{
//            print("User failed to log in with facebook")
//            return
//        }
//
//        let credential = FacebookAuthProvider.credential(withAccessToken: token)
//
//        FirebaseAuth.Auth.auth().signIn(with: credential, completion: {[weak self] authResult, error in
//            guard authResult != nil, error == nil else{
//                print("Facebook credential login failed, MFA may be need")
//                return
//            }
//            print("Successfully logged user in")
//            self?.navigationController?.dismiss(animated: true, completion: nil)
//        })
//    }
//}
