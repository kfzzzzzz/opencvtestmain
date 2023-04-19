//
//  messageListCell.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/28/23.
//

import Foundation
import UIKit
import SnapKit

class messageListCell: UITableViewCell {
    
    private var message: Message?
    
    private lazy var avaterImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5.atScale()
        image.layer.masksToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.pink1().cgColor
        self.addSubview(image)
        return image
    }()
    
    private lazy var senderName : UILabel = {
        let label = UILabel()
        label.font = UIFont.SmileySans(12.atScale())
        label.textColor = UIColor.gray
        label.backgroundColor = .clear
        self.addSubview(label)
        return label
    }()
    
    private lazy var messageBubbleView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.pink2()
        view.layer.cornerRadius = 10.atScale()
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()
    
    private lazy var messageBubbleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        selectionStyle = .none
        selectedBackgroundView = .none
        setConstraints()
    }
    
    func setConstraints(){
        avaterImage.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10.atScale())
            make.height.width.equalTo(37.atScale())
        }
        senderName.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalTo(avaterImage.snp.right).offset(10.atScale())
            make.height.equalTo(12.atScale())
        }
        messageBubbleView.snp.makeConstraints{ make in
            make.top.equalTo(senderName.snp.bottom).offset(5.atScale())
            make.left.equalTo(avaterImage.snp.right).offset(10.atScale())
            make.right.equalToSuperview().offset(-10.atScale())
            make.bottom.equalToSuperview().offset(-25.atScale())
        }
        messageBubbleView.addSubview(messageBubbleLabel)
        messageBubbleLabel.snp.makeConstraints { make in
            make.leading.equalTo(messageBubbleView.snp.leading).offset(8.atScale())
            make.top.equalTo(messageBubbleView.snp.top).offset(8.atScale())
            make.trailing.equalTo(messageBubbleView.snp.trailing).offset(-8.atScale())
            make.bottom.equalTo(messageBubbleView.snp.bottom).offset(-8.atScale())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(message: Message, avatar: UIImage){
        self.message = message
        messageBubbleLabel.text = message.body
        senderName.text = message.senderNam
        self.avaterImage.image = avatar
    }
    
}
