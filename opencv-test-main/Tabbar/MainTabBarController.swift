//
//  MainTabBarController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/10/23.
//

import UIKit
import flutter_boost

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
            initTabBar()
        
        //allFont()
        }
        
        func initTabBar() {
            
            self.tabBar.insertSubview(drawTabBarImageView(), at: 0)
            self.tabBar.isOpaque = true
            
            let home = ChatViewController()
            home.tabBarItem.title = "首页"

            let chat = ChatViewController()
            chat.tabBarItem.title = "聊天"

            let mid = FrontPageViewController()
            mid.tabBarItem.title = ""
            mid.tabBarItem.imageInsets = UIEdgeInsets(top: -standOutHeight/3.8, left: 0, bottom: standOutHeight/3.8, right: 0)
            mid.tabBarItem.image = UIImage(named: "MainTabIcon.png")?.withRenderingMode(.alwaysOriginal)

            let vc:FBFlutterViewContainer = FBFlutterViewContainer()
            let options = FlutterBoostRouteOptions()
            options.pageName = "example"
            vc.setName(options.pageName, uniqueId: options.uniqueId, params: options.arguments,opaque: options.opaque)
            let challenge = vc
            challenge.tabBarItem.title = "chatGPT"

            let mine = LoginViewController()
            mine.tabBarItem.title = "我的"

            viewControllers = [chat, mid, challenge]
            
            self.tabBar.isTranslucent = false
            self.selectedIndex = 1
            
        
            // 设置 tabBar & tabBarItem
            setTabBarItemAttributes(fontName: "SmileySans-Oblique", normalfontSize: 14, selectedfontSize: 18, normalColor: .white, selectedColor: .white, bgColor: UIColor.pink1())
        }

    /// 设置属性
    func setTabBarItemAttributes(fontName: String, normalfontSize: CGFloat,selectedfontSize: CGFloat,normalColor: UIColor,selectedColor: UIColor,bgColor: UIColor) {
        var attributesNormal: [NSAttributedString.Key: Any] = [.font: UIFont(name: fontName, size: normalfontSize)!]
        attributesNormal[.foregroundColor] = normalColor
        var attributesSelected: [NSAttributedString.Key: Any] = [.font: UIFont(name: fontName, size: selectedfontSize)!]
        attributesSelected[.foregroundColor] = selectedColor
        tabBar.tintColor = selectedColor
        tabBar.barTintColor = bgColor
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = attributesNormal
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = attributesSelected
            appearance.backgroundColor = UIColor.pink1()
            self.tabBar.scrollEdgeAppearance = appearance;
        }else{
            UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
        }
    }
    
    
    
    
    
}
