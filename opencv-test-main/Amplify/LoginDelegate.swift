//
//  LoginDelegate.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/22/23.
//

import Foundation
import UIKit

protocol LoginDelegate : AnyObject{
    
    func isLogin()
    
    func isLogout()
    
    func updateUserInfo()
}


