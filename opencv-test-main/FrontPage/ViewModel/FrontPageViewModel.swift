//
//  FrontPageViewModel.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 3/27/23.
//

import Foundation
import UIKit

class FrontPageViewModel {
    
    var item : [frontPageItem] = []
    
    func mockData(){
        self.item.append(frontPageItem(title: "这是测试的标题", image: UIImage(named: "EmptyView"), message: "啊啊啊啊啊啊呃呃呃呃呃啊啊啊啊谁谁谁啊嘻嘻嘻sodas问起我而去玩俄武器恶趣味请问请问阿斯顿擦色 213 21 深爱的啊啥的1/s/?"))
    }
}

struct frontPageItem {
    var title : String?
    var image : UIImage?
    var message : String?
}
