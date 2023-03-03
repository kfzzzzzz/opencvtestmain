//
//  FrontPageViewController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/17/23.
//

import UIKit
import SnapKit
import Kingfisher

class FrontPageViewController: UIViewController {
    
    static var avatarWidth : CGFloat = 28.atScale()
    
    private let leftProfileVC = LeftProfileViewController()
    
    private lazy var leftTopIcon : UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(openLeftProfile), for: .touchUpInside)
        button.setImage(UIImage(named: "ic_frontPage_leftTop"), for: .normal)
        view.addSubview(button)
        return button
    }()
    
    private lazy var rightHeadPortrait: UIImageView = {
        var image = UIImageView(image: UIImage(named: "avatarPlaceholder"))
        image.layer.cornerRadius = FrontPageViewController.avatarWidth/2
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.pink1().cgColor
        view.addSubview(image)
        return image
    }()
    
    private lazy var rightNameLabel : UILabel = {
        var label = UILabel()
        label.text = "未登录"
        label.textAlignment = .center
        label.font = UIFont.SmileySans(16.atScale())
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        view.addSubview(label)
        return label
    }()
    
    private lazy var loginButton : UIButton = {
        var button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        NotificationCenter().removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AccountManager.shared.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        leftTopIcon.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(18.atScale())
            make.left.equalToSuperview().offset(30.atScale())
            make.height.equalTo(14.atScale())
            make.width.equalTo(22.atScale())
        }
        leftTopIcon.extendEdgeInsets = UIEdgeInsets(top: 20.atScale(), left: 20.atScale(), bottom: 20.atScale(), right: 20.atScale())
        rightNameLabel.snp.makeConstraints{ make in
            make.top.equalTo(leftTopIcon.snp.top).offset(-4.atScale())
            make.right.equalToSuperview().offset(-30.atScale())
            make.height.equalTo(26.atScale())
            make.width.equalTo(68.atScale())
        }
        rightHeadPortrait.snp.makeConstraints{ make in
            make.top.equalTo(leftTopIcon.snp.top).offset(-6.atScale())
            make.right.equalTo(rightNameLabel.snp.left)
            make.width.height.equalTo(FrontPageViewController.avatarWidth)
        }
        loginButton.snp.makeConstraints{ make in
            make.top.equalTo(rightHeadPortrait.snp.top).offset(-4.atScale())
            make.bottom.equalTo(rightHeadPortrait.snp.bottom).offset(4.atScale())
            make.left.equalTo(rightHeadPortrait.snp.left)
            make.right.equalTo(rightNameLabel.snp.right)
        }
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(openLeftProfile))
//        leftTopIcon.addGestureRecognizer(gesture)
    }
    
    @objc func setUserInfo(){
        print("UserData.shared.isSignedIn:\(UserData.shared.isSignedIn)")
        if UserData.shared.isSignedIn {
            if UserData.shared.userImageURL != ""{
                AccountManager.shared.retrieveImage(name: UserData.shared.userImageURL) { (data) in
                    DispatchQueue.main.async() {
                        let uim = UIImage(data: data)
                        if UserData.shared.isSignedIn {
                            self.rightHeadPortrait.image = uim
                            self.rightNameLabel.text = UserData.shared.userName
                            self.leftProfileVC.setAvater(image: ((uim ?? UIImage(named: "avatarPlaceholder"))!) )
                            UserData.shared.userImage = uim
                        }
                    }
                }
            }else{
                AccountManager.shared.retrieveImage(name: "TestLovePic%403x.png") { (data) in
                    DispatchQueue.main.async() {
                        let uim = UIImage(data: data)
                        if UserData.shared.isSignedIn {
                            self.rightHeadPortrait.image = uim
                            self.rightNameLabel.text = UserData.shared.userName
                            self.leftProfileVC.setAvater(image: ((uim ?? UIImage(named: "avatarPlaceholder"))!) )
                            UserData.shared.userImage = uim
                        }
                    }
                }
            }
        }else{
            DispatchQueue.main.async() {
                self.rightHeadPortrait.image = UIImage(named: "avatarPlaceholder")
                self.rightNameLabel.text = UserData.shared.userName
            }
        }

    }
    
    @objc func loginButtonTapped(){
        
        if UserData.shared.isSignedIn == false{
            AccountManager.shared.signIn()
        }else{
            self.showAlert()
        }
        
    }
    
    @objc func openLeftProfile(){
        leftProfileVC.show()
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: "是否确认退出登录", message: "被气到了？？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确认", style: .default, handler: {
            action in
            AccountManager.shared.signOut()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}


extension FrontPageViewController: LoginDelegate {
    func isLogin() {
        self.setUserInfo()
        leftProfileVC.isLogin = UserData.shared.isSignedIn
    }
    
    func isLogout() {
        self.setUserInfo()
        leftProfileVC.isLogin = UserData.shared.isSignedIn
    }
    
    func updateUserInfo() {
        self.setUserInfo()
        leftProfileVC.isLogin = UserData.shared.isSignedIn
    }
    
    
}
