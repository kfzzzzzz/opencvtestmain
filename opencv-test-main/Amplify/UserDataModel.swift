//
//  UserDataModel.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 1/31/23.
//
import Foundation
import UIKit

// singleton object to store user data
class UserData {
    private init() {}
    static let shared = UserData()
    
    public var id: String = "-1"
    public var userId : String = "-1"
    public var userName : String = "未登录"
    public var userImageURL : String = ""
    public var isSignedIn : Bool = false
    public var userImage : UIImage?
    
    func clear(){
        self.id = "-1"
        self.userId = "-1"
        self.userName = "未登录"
        self.userImageURL = ""
        self.isSignedIn = false
        self.userImage = nil
    }
    
}

