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
        
        print("KFZTEST: UserData.shared.isSignedIn:\(UserData.shared.isSignedIn)")
        if UserData.shared.isSignedIn {
            self.setAvatarImage()
        }
        
        view.addSubview(image)
        return image
    }()
    
    private lazy var rightNameLabel : UILabel = {
        var label = UILabel()
        label.text = "孔繁臻"
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
        print("KFZTEST:addObserver")
            NotificationCenter.default.addObserver(self, selector: #selector(self.setAvatarImage), name: .loginDidSucceed, object: nil)
        print("KFZTEST:Thread:\(Thread.current)")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("KFZTEST:deinit")
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
    
    @objc func setAvatarImage(){
        print("KFZTEST:setAvatarImage")
        Backend.shared.retrieveImage(name: "TestLovePic@3x.png") { (data) in
            // update the UI on the main thread
            DispatchQueue.main.async() {
                let uim = UIImage(data: data)
                self.rightHeadPortrait.image = uim
            }
        }
    }
    
    @objc func loginButtonTapped(){
        
        if UserData.shared.isSignedIn == false{
            Backend.shared.signIn()
        }else{
            Backend.shared.signOut()
        }
        
    }
    
}
