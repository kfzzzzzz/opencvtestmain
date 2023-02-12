//
//  TestTabVIew.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2023/2/12.
//

import UIKit

class TestTabVIew : UITabBarController {

    let tabBarImgs = ["home@2x", "cart@2x", "center@2x", "cart@2x", "personal@2x"]
    let tabBarSelImgs = ["home_sel@2x", "cart_sel@2x", "center_sel@2x", "cart_sel@2x", "personal_sel@2x"]
    let tabTitles = ["救援", "福利", "", "商品", "我的"]
    // 2 设置背景颜色
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundImage = UIImage.init()
        UITabBar.appearance().shadowImage = UIImage.init()
        
        // 3 设置背景图片
        self.tabBar.insertSubview(drawTabBarImageView(), at: 0)
        self.tabBar.isOpaque = true
        self.viewControllers = [LoginViewController(), LoginViewController(), LoginViewController(),  LoginViewController(), LoginViewController()]
        for i in 0...(tabTitles.count - 1){
            let tabBarItem: UITabBarItem = self.tabBar.items![i]
            tabBarItem.image = UIImage.init(named: tabBarImgs[i])?.withRenderingMode(.alwaysOriginal)
            tabBarItem.selectedImage = UIImage.init(named: tabBarSelImgs[i])?.withRenderingMode(.alwaysOriginal)
            tabBarItem.title = tabTitles[i]
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(white: 0.6, alpha: 1.0)], for: .normal)
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .selected)
            if i == 2{
                tabBarItem.imageInsets = UIEdgeInsets(top: -standOutHeight/3.8, left: 0, bottom: standOutHeight/3.8, right: 0)
            }
            self.selectedIndex = 2
        }
        
        
        
    }
//    UITabBar.appearance().backgroundImage = UIImage.init()
//    UITabBar.appearance().shadowImage = UIImage.init()
}
