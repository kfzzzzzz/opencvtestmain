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
    public var userId : String = ""
    public var userName : String = ""
    public var userImage : String = ""
    public var isSignedIn : Bool = false
    
    func clear(){
        self.userId = ""
        self.userName = ""
        self.userImage = ""
        self.isSignedIn = false
    }
    
}

