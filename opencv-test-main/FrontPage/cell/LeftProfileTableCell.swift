//
//  LeftProfileTableCell.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/24/23.
//

import Foundation
import UIKit
import SnapKit

class LeftProfileTableCell: UITableViewCell {
    
    private lazy var leftIcon : UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var itemLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.PFRegular(16.atScale())
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        selectionStyle = .none
        selectedBackgroundView = .none
        
        leftIcon.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(60.atScale())
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15.atScale())
        }
        itemLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.left.equalTo(leftIcon.snp.right).offset(24.atScale())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setcell(image: String, title: String){
        self.leftIcon.image = UIImage(named: image)
        self.itemLabel.text = title
    }
    
    
}
