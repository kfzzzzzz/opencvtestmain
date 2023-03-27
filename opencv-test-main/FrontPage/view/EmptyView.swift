//
//  EmptyView.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 3/27/23.
//

import UIKit
import SnapKit

class EmptyView : UIView {
    
    private lazy var emptyImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "EmptyView")
        image.contentMode = .scaleAspectFill
        self.addSubview(image)
        return image
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.PFSemibold(18)
        label.textColor = .pink1()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "暂无更多气人内容"
        self.addSubview(label)
        return label
    }()
    
    init(){
        super.init(frame: .zero)
        
        emptyImage.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10.atScale())
            make.width.height.equalTo(300.atScale())
        }
        label.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyImage.snp.bottom).offset(10.atScale())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
