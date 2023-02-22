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
    
    private lazy var leftTopIcon : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "ic_frontPage_leftTop")
        view.addSubview(image)
        return image
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
        AccountManager.shared.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        NotificationCenter().removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        leftTopIcon.snp.makeConstraints{ make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(18.atScale())
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(18.atScale())
            }
            make.left.equalToSuperview().offset(30.atScale())
            make.height.equalTo(12.atScale())
            make.width.equalTo(20.atScale())
        }
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
    }
    
    @objc func setUserInfo(){
        print("UserData.shared.isSignedIn:\(UserData.shared.isSignedIn)")
        if UserData.shared.isSignedIn {
            AccountManager.shared.retrieveImage(name: "TestLovePic@3x.png") { (data) in
                DispatchQueue.main.async() {
                    let uim = UIImage(data: data)
                    if UserData.shared.isSignedIn {
                        self.rightHeadPortrait.image = uim
                    }
                }
            }
        }else{
            DispatchQueue.main.async() {
                self.rightHeadPortrait.image = UIImage(named: "avatarPlaceholder")
                self.rightNameLabel.text = "未登录"
            }
        }

    }
    
    @objc func loginButtonTapped(){
        
        if UserData.shared.isSignedIn == false{
            AccountManager.shared.signIn()
        }else{
            AccountManager.shared.signOut()
        }
        
    }
    
}


extension FrontPageViewController: LoginDelegate {
    func isLogin() {
        self.setUserInfo()
    }
    
    func isLogout() {
        self.setUserInfo()
    }
    
    func updateUserInfo() {
        self.setUserInfo()
    }
    
    
}
