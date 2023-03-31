//
//  LeftProfileViewController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/23/23.
//

import Foundation
import UIKit
import SnapKit

class LeftProfileViewController : UIViewController {
    
    var isLogin : Bool = UserData.shared.isSignedIn{
        didSet{
            self.userInfoView.isLogin = isLogin
            DispatchQueue.main.async() {
                if self.isLogin{
                    self.loginOutButton.setTitle("退出登录", for: .normal)
                }else{
                    self.loginOutButton.setTitle("前往登录", for: .normal)
                }
            }
        }
    }
    
    private lazy var itemTableView : UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.isScrollEnabled = false
        table.register(LeftProfileTableCell.self, forCellReuseIdentifier: "leftProfileTableCell")
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        if #available(iOS 13.0, *) {
            table.automaticallyAdjustsScrollIndicatorInsets = false
        }else {
            // Fallback on earlier versions
        }
        self.view.addSubview(table)
        return table
    }()
    
    private lazy var userInfoView : FrontPageAvatarView = {
        let view = FrontPageAvatarView()
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var closeImageView : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "FrontPageClose"), for: .normal)
        button.addTarget(self, action: #selector(dissmisscction), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var loginOutButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("退出登录", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(loginOutTapped), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var loginOutImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "LoginOutIcon")
        self.view.addSubview(image)
        return image
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        itemTableView.delegate = self
        itemTableView.dataSource = self
        self.view.backgroundColor = .white
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
        closeImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(23.atScale())
            make.right.equalToSuperview().offset(-43.atScale())
            make.width.height.equalTo(30.atScale())
        }
        closeImageView.extendEdgeInsets = UIEdgeInsets(top: 20.atScale(), left: 20.atScale(), bottom: 20.atScale(), right: 20.atScale())
        userInfoView.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(60.atScale())
            make.height.equalTo(FrontPageAvatarView.avatarImageWidth)
            make.width.equalTo(172.atScale())
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(75.atScale())
        }
        itemTableView.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.top.equalTo(userInfoView.snp.bottom).offset(40.atScale())
            make.bottom.equalToSuperview()
        }
        loginOutImage.snp.makeConstraints{ make in
            var SafeHeight : CGFloat = 0
            SafeHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            make.bottom.equalTo( -50.atScale() - SafeHeight)
            make.left.equalToSuperview().offset(140.atScale())
            make.width.height.equalTo(20.atScale())
        }
        loginOutButton.snp.makeConstraints{ make in
            make.left.equalTo(loginOutImage.snp.right).offset(17.5.atScale())
            make.top.bottom.equalTo(loginOutImage)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func show(above viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController,
              completion: (() -> Void)? = nil) {
        viewController?.present(self, animated: true, completion: completion)
    }
    
    @objc func dissmisscction(){
        self.dismiss(animated: true)
    }
    
    @objc func loginOutTapped(){
        print("loginOutTapped")
        if UserData.shared.isSignedIn{
            self.showAlert()
        }else{
            AccountManager.shared.signIn()
        }
    }
    
    func setAvater(image: UIImage){
        self.userInfoView.setAvatarOnline(image: image)
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

extension LeftProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leftProfileTableCell", for: indexPath) as! LeftProfileTableCell
        if indexPath.row == 0 {
            cell.setcell(image: "ProfileIcon", title: "我的")
        }
        if indexPath.row == 1 {
            cell.setcell(image: "ChatIcon", title: "聊天")
        }
        if indexPath.row == 2{
            cell.setcell(image: "SettingIcon", title: "设置")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.atScale()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UserData.shared.isSignedIn == false{
            AccountManager.shared.signIn()
        }else{
            if indexPath.row == 0 {
                stableDiffusionManager.shared.testRequest()
            }
            if indexPath.row == 2 {
                let vc = SettingViewController()
                vc.show()
            }
        }
    }
}

extension LeftProfileViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        LeftProfileShowAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        LeftProfileDismissAnimation()
    }
}


