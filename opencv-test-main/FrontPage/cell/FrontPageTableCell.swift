//
//  FrontPageTableCell.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 3/27/23.
//

import Foundation
import UIKit
import SnapKit

class FrontPageTableCell: UITableViewCell {
    
    private lazy var bgView : UIView = {
        let view = UIView()
        view.backgroundColor = .pink1()
        return view
    }()
    
    private lazy var itemImage : UIImageView = {
        let image = UIImageView()
        self.addSubview(image)
        return image
    }()
    
    private lazy var itemTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.PFRegular(17.atScale())
        self.addSubview(label)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        selectionStyle = .none
        selectedBackgroundView = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

