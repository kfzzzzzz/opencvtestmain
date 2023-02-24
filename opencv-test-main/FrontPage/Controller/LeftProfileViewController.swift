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
        
    private lazy var itemTableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .red
        table.register(LeftProfileTableCell.self, forCellReuseIdentifier: "leftProfileTableCell")
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        if #available(iOS 13.0, *) {
            table.automaticallyAdjustsScrollIndicatorInsets = false
        }else {
            // Fallback on earlier versions
        }
        //self.view.addSubview(itemTableView)
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
    
    init(){
        super.init(nibName: nil, bundle: nil)
        itemTableView.delegate = self
        itemTableView.dataSource = self
        self.view.backgroundColor = .yellow
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
//        itemTableView.snp.makeConstraints{ make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(userInfoView.snp.bottom).offset(40.atScale())
//        }
        
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
    
}

extension LeftProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leftProfileTableCell", for: indexPath) as! LeftProfileTableCell
        if indexPath.row == 0 {
            cell.setcell(image: "ProfileIcon", title: "我的")
        }
        if indexPath.row == 1 {
            cell.setcell(image: "ChatIcon", title: "聊天")
        }
        return cell
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
