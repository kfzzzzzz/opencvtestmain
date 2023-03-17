//
//  chatGPTTableCell.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 3/16/23.
//

import Foundation
import UIKit
import SnapKit
//import PaddingLabel

class chatGPTTableCell: UITableViewCell {
    
    enum type{
        case user
        case chatGPT
    }
    
    private var type: type?
    
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
        label.padding(10.atScale(), 10.atScale(), 10.atScale(), 10.atScale())
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
    
    func setData(text: String, type: type){
        messageBubble.text = text
        switch type{
        case .user:
            senderName.text = UserData.shared.userName
            self.avaterImage.image = UserData.shared.userImage
        case .chatGPT:
            senderName.text = "ChatGPT"
            self.avaterImage.image = UIImage(named: "GPT")
        }
    }
    
}
