//
//  messageListV2Cell.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 4/19/23.
//

import UIKit
import SnapKit

class messageListV2Cell: UITableViewCell {
    
    let bubbleView = UIView()
    let messageLabel = UILabel()
    let usernameLabel = UILabel()
    let avatarImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        bubbleView.backgroundColor = UIColor.pink2()
        bubbleView.layer.cornerRadius = 16
        bubbleView.layer.masksToBounds = true
        
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.isUserInteractionEnabled = true
        
        usernameLabel.font = UIFont.systemFont(ofSize: 14)
        
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 16
        avatarImageView.layer.masksToBounds = true
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        
        avatarImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8.atScale())
            make.top.equalToSuperview().offset(8.atScale())
            make.width.height.equalTo(32.atScale())
        }
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.trailing.equalTo(bubbleView.snp.trailing).offset(-8)
            make.bottom.equalTo(avatarImageView)
            make.height.equalTo(20)
        }
        bubbleView.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-60)
            make.bottom.equalToSuperview().offset(-8)
        }
        messageLabel.snp.makeConstraints { make in
            make.leading.equalTo(bubbleView.snp.leading).offset(8)
            make.top.equalTo(bubbleView.snp.top).offset(8)
            make.trailing.equalTo(bubbleView.snp.trailing).offset(-8)
            make.bottom.equalTo(bubbleView.snp.bottom).offset(-8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return true
        }
        return false
    }
    
    override func copy(_ sender: Any?) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = messageLabel.text
    }
    
    func setData(message: Message, avatar: UIImage){
        messageLabel.text = message.body
        usernameLabel.text = message.sender?.UserName ?? ""
        avatarImageView.image = avatar
    }
}
