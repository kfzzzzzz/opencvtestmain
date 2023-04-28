//
//  UserDataModel.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 1/31/23.
//
import Foundation
import UIKit


class UserData {
    private init() {}
    static let shared = UserData()

    public var isSignedIn : Bool = false
    public var userPhoneNumber : String  = ""
    public var userId : String = "-1"
    public var userName : String = "气人小子"
    public var userImageURL : String = ""
    public var userImage : UIImage?
    
    func clear(){
        self.isSignedIn = false
        self.userPhoneNumber = ""
        self.userId = "-1"
        self.userName = "气人小子"
        self.userImageURL = ""
        self.userImage = nil
    }
}

