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
    
    private var viewModel : FrontPageViewModel = FrontPageViewModel()
    
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
        var image = UIImageView(image: UserData.shared.userImage)
        image.layer.cornerRadius = FrontPageViewController.avatarWidth/2
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.pink1().cgColor
        view.addSubview(image)
        return image
    }()
    
    private lazy var rightNameLabel : UILabel = {
        var label = UILabel()
        label.text = UserData.shared.userName
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
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    private lazy var frontPageTableView : UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.isScrollEnabled = false
        table.register(FrontPageTableCell.self, forCellReuseIdentifier: "FrontPageTableCell")
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
    
    private lazy var emptyView : EmptyView = {
        let view = EmptyView()
        view.isHidden = true
        self.view.addSubview(view)
        return view
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.frontPageTableView.delegate = self
        self.frontPageTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserInfo), name: Notification.Name.updateUserData, object: nil)
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
        emptyView.snp.makeConstraints{ make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
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
        frontPageTableView.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(72.atScale())
            make.left.equalToSuperview().offset(30.atScale())
            make.right.equalToSuperview().offset(-30.atScale())
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func updateUserInfo(){
        rightHeadPortrait.image = UserData.shared.userImage
        rightNameLabel.text = UserData.shared.userName
    }
    
    @objc func openLeftProfile(){
        leftProfileVC.show()
    }
    
    @objc func showAlert(){
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

extension FrontPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.item.count == 0{
            self.emptyView.isHidden = false
        }else{
            self.emptyView.isHidden = true
        }
        return viewModel.item.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FrontPageTableCell", for: indexPath) as! FrontPageTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.atScale()
    }
}
