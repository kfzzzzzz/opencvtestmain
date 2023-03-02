//
//  messageListCell.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/28/23.
//

import Foundation
import UIKit
import SnapKit
import PaddingLabel

class messageListCell: UITableViewCell {
    
    private var message: Message?
    private var sender: UserTest?
    
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
    
    private lazy var messageBubble: PaddingLabel = {
        let label = PaddingLabel()
        label.topInset = 10.atScale()
        label.bottomInset = 10.atScale()
        label.leftInset = 10.atScale()
        label.rightInset = 10.atScale()
        label.numberOfLines = 0
        label.backgroundColor = UIColor.pink1()
        label.layer.cornerRadius = 10.atScale()
        label.layer.masksToBounds = true
        self.addSubview(label)
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
        messageBubble.snp.makeConstraints{ make in
            make.top.equalTo(senderName.snp.bottom).offset(5.atScale())
            make.left.equalTo(avaterImage.snp.right).offset(10.atScale())
            make.right.equalToSuperview().offset(-10.atScale())
            make.bottom.equalToSuperview().offset(-25.atScale())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(message: Message){
        self.message = message
        self.sender = message.sender
        messageBubble.text = message.body
        senderName.text = sender?.userName
        AccountManager.shared.retrieveImage(name: sender?.userImage ?? "TestLovePic%403x.png"){(data) in
            DispatchQueue.main.async() {
                let uim = UIImage(data: data)
                self.avaterImage.image = uim
            }
        }
    }
    
}
