//
//  FrontPageAvatarView.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/24/23.
//

import Foundation
import UIKit
import SnapKit

class FrontPageAvatarView : UIView{
    
    static let avatarImageWidth : CGFloat = 60.atScale()
    
    private lazy var avatarImage : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = FrontPageAvatarView.avatarImageWidth/2
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.pink1().cgColor
        image.image = UIImage(named: "avatarPlaceholder")
        self.addSubview(image)
        return image
    }()
    
    private lazy var avatarTopRight : UIView  = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = FrontPageAvatarView.avatarImageWidth/6
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()
    
    private lazy var userNameLable : UILabel = {
        let label = UILabel()
        label.text = "sssssssssss"
        label.numberOfLines = 1
        label.font = UIFont.PFSemibold(16.atScale())
        label.lineBreakMode = .byTruncatingTail
        self.addSubview(label)
        return label
    }()
    
    private lazy var userStauts : UILabel = {
        let label = UILabel()
        label.text = "offline"
        label.textColor = .gray
        label.font = UIFont.PFRegular(14.atScale())
        self.addSubview(label)
        return label
    }()
    
    
    init(){
        super.init(frame: .zero)
        avatarImage.snp.makeConstraints{ make in
            make.top.left.equalToSuperview()
            make.height.width.equalTo(FrontPageAvatarView.avatarImageWidth)
        }
        avatarTopRight.snp.makeConstraints{ make in
            make.top.right.equalTo(avatarImage)
            make.height.width.equalTo(FrontPageAvatarView.avatarImageWidth/3)
        }
        userNameLable.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(5.atScale())
            make.height.equalTo(20.atScale())
            make.width.equalTo(100.atScale())
            make.left.equalTo(avatarImage.snp.right).offset(12.atScale())
        }
        userStauts.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-5.atScale())
            make.height.equalTo(14.atScale())
            make.width.equalTo(100.atScale())
            make.left.equalTo(userNameLable)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
