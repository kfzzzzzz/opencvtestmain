//
//  MainTabBarController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/10/23.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
            initTabBar()
        
        allFont()
        }
        
        func initTabBar() {
            let home = LoginViewController()
            home.tabBarItem.title = "首页"

            let category = LoginViewController()
            category.tabBarItem.title = "分类"
            category.tabBarItem.image = UIImage(named: "category.png")

            let found = LoginViewController()
            found.tabBarItem.title = "发现"

//            let cart = LoginViewController()
//            cart.tabBarItem.title = "购物车"
//            cart.tabBarItem.image = UIImage(named: "cart.png")

            let mine = LoginViewController()
            mine.tabBarItem.title = "我的"
            //var test = SVGKImage(named: "mine.svg")
            mine.tabBarItem.image = UIImage(named: "Mine.svg")

            viewControllers = [home, category, found, mine]

            // 设置 tabBar & tabBarItem
            setTabBarItemAttributes(bgColor: UIColor(hex: 0xFF6480))
            
        }

        /// 这种方式比较灵活
        func setTabBarItemAttributes(fontName: String = "SmileySans-Oblique",
                                     fontSize: CGFloat = 16,
                                     normalColor: UIColor = .white,
                                     selectedColor: UIColor = .red,
                                     bgColor: UIColor = .white) {
            // tabBarItem 文字大小
            var attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: fontName, size: fontSize)!]
            
            // tabBarItem 文字默认颜色
            attributes[.foregroundColor] = normalColor
            UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
            
            // tabBarItem 文字选中颜色
            attributes[.foregroundColor] = selectedColor
            UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
            
            // tabBar 文字、图片 统一选中高亮色
            tabBar.tintColor = selectedColor
            
            // tabBar 背景色
            tabBar.barTintColor = bgColor
        }
    
    
}
