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
    public var notes : [Note] = []
    public var isSignedIn : Bool = false
    
}

// the data class to represents Notes
class Note : Identifiable {
    var id : String
    var name : String
    var description : String?
    var imageName : String?
    public var image : UIImage?

    init(id: String, name: String, description: String? = nil, image: String? = nil ) {
        self.id = id
        self.name = name
        self.description = description
        self.imageName = image
    }
    
    convenience init(from data: NoteData) {
        self.init(id: data.id, name: data.name, description: data.description, image: data.image)
     
        // store API object for easy retrieval later
        self._data = data
    }
     
    fileprivate var _data : NoteData?
     
    // access the privately stored NoteData or build one if we don't have one.
    var data : NoteData {
     
        if (_data == nil) {
            _data = NoteData(id: self.id,
                                name: self.name,
                                description: self.description,
                                image: self.imageName)
        }
     
        return _data!
    }
    
    
}

// this is a test data set to preview the UI in Xcode
func prepareTestData() -> UserData {
    let userData = UserData.shared
    userData.isSignedIn = true
    let desc = "this is a very long description that should fit on multiiple lines.\nit even has a line break\nor two."

    let n1 = Note(id: "01", name: "Hello world", description: desc, image: "mic")
    let n2 = Note(id: "02", name: "A new note", description: desc, image: "phone")

    if #available(iOS 13.0, *) {
        n1.image = UIImage(systemName: n1.imageName!)
        n2.image = UIImage(systemName: n2.imageName!)
    } 

    userData.notes = [ n1, n2 ]

    return userData
}


extension Notification.Name {
    /// 自动登录成功的通知
    static let autoLoginDidSucceed = Notification.Name("autoLoginDidSucceed")
    
    /// 自动登录失败的通知
    static let autoLoginDidFail = Notification.Name("autoLoginDidFail")
    
    /// 登录成功的通知
    static let loginDidSucceed = Notification.Name("loginDidSucceed")
    
    /// 登录成功的通知
    static let loginDidFail = Notification.Name("loginDidFail")
    
    /// 将要退出登录
    static let accountWillLogout = Notification.Name("accountWillLogout")
    
    /// 已经退出登录
    static let accountDidLogout = Notification.Name("accountDidLogout")
    
    /// 绑定成功
    static let accountDidBound = Notification.Name("accountDidBound")
}


