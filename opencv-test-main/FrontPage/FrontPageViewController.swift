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
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(18.atScale())
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
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(openLeftProfile))
//        leftTopIcon.addGestureRecognizer(gesture)
    }
    
    @objc func setUserInfo(){
        print("UserData.shared.isSignedIn:\(UserData.shared.isSignedIn)")
        if UserData.shared.isSignedIn {
            if UserData.shared.userImage != ""{
                AccountManager.shared.retrieveImage(name: UserData.shared.userImage) { (data) in
                    DispatchQueue.main.async() {
                        let uim = UIImage(data: data)
                        if UserData.shared.isSignedIn {
                            self.rightHeadPortrait.image = uim
                            self.rightNameLabel.text = UserData.shared.userName
                        }
                    }
                }
            }else{
                self.rightHeadPortrait.kf.setImage(with: URL.init(string: "https://opencvtestmain931da04b00a94538b68685b4d5e11082185547-dev.s3.ap-northeast-1.amazonaws.com/public/TestLovePic%403x.png"))
                self.rightNameLabel.text = UserData.shared.userName
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
            AccountManager.shared.signOut()
        }
        
    }
    
    @objc func openLeftProfile(){
        let vc = LeftProfileViewController()
        //vc.modalPresentationStyle = .fullScreen
        //self.present(vc, animated: false)
        vc.show()
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
