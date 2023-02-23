//
//  AccountManager.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 1/31/23.
//

import UIKit
import Amplify
import AmplifyPlugins

class AccountManager : NSObject {
    
    static let shared = AccountManager()
    
    weak var delegate: LoginDelegate?
    private override init() {
        super.init()
        
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            try Amplify.add(plugin: AWSS3StoragePlugin())
            let models = AmplifyModels()
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: models))
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            print("Could not initialize Amplify: \(error)")
        }
        
        _ = Amplify.Hub.listen(to: .auth) { (payload) in
            switch payload.eventName {
            case HubPayload.EventName.Auth.signedIn:
                print("==HUB== User signed In, update UI")
                self.updateUserData(withSignInStatus: true)
            case HubPayload.EventName.Auth.signedOut:
                print("==HUB== User signed Out, update UI")
                self.updateUserData(withSignInStatus: false)
            case HubPayload.EventName.Auth.sessionExpired:
                print("==HUB== Session expired, show sign in UI")
                self.updateUserData(withSignInStatus: false)
            default:
                //print("==HUB== \(payload)")
                break
            }
        }
        // let's check if user is signedIn or not
        _ = Amplify.Auth.fetchAuthSession { (result) in
            do {
                let session = try result.get()
                self.updateUserData(withSignInStatus: session.isSignedIn)
            } catch {
                print("Fetch auth session failed with error - \(error)")
            }
        }
    }
    
    // signin with Cognito web user interface
    public func signIn() {
        _ = Amplify.Auth.signInWithWebUI(presentationAnchor: UIApplication.shared.windows.first!) { result in
            switch result {
            case .success(_):
                self.delegate?.isLogin()
                print("Sign in succeeded")
            case .failure(let error):
                print("Sign in failed \(error)")
            }
        }
    }
    
    // signout
    public func signOut() {
        _ = Amplify.Auth.signOut() { (result) in
            switch result {
            case .success:
                UserData.shared.clear()
                self.delegate?.isLogout()
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    // change our internal state, this triggers an UI update on the main thread
    func updateUserData(withSignInStatus status : Bool) {
        DispatchQueue.main.async() {
            let userData : UserData = .shared
            userData.isSignedIn = status
            if status {
                userData.userId = Amplify.Auth.getCurrentUser()?.userId ?? "-1"
                //NotificationCenter.default.post(name: .loginDidSucceed, object: nil)
                self.checkCreateUser()
            } else {
                userData.clear()
            }
            self.delegate?.updateUserInfo()
        }
    }
    
    // MARK: - Image Storage
    
    func storeImage(name: String, image: Data) {
        
        //        let options = StorageUploadDataRequest.Options(accessLevel: .private)
        let _ = Amplify.Storage.uploadData(key: name, data: image,// options: options,
                                           progressListener: { progress in
            // optionlly update a progress bar here
        }, resultListener: { event in
            switch event {
            case .success(let data):
                print("Image upload completed: \(data)")
            case .failure(let storageError):
                print("Image upload failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        })
    }
    
    func retrieveImage(name: String, completed: @escaping (Data) -> Void) {
        let _ = Amplify.Storage.downloadData(key: name,
                                             progressListener: { progress in
            // in case you want to monitor progress
        }, resultListener: { (event) in
            switch event {
            case let .success(data):
                print("Image \(name) loaded")
                completed(data)
            case let .failure(storageError):
                print("Can not download image: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        }
        )
    }
    
    func deleteImage(name: String) {
        let _ = Amplify.Storage.remove(key: name,
                                       resultListener: { (event) in
            switch event {
            case let .success(data):
                print("Image \(data) deleted")
            case let .failure(storageError):
                print("Can not delete image: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        }
        )
    }
    
    func checkCreateUser(){
        Amplify.DataStore.query(UserTest.self, where: UserTest.keys.userId == UserData.shared.userId){ result in
            switch result{
            case .success(let date):
                if date.isEmpty{
                    Amplify.DataStore.save(UserTest(userName: "气人小子", userId: UserData.shared.userId) ){ result in
                        switch result{
                        case .success(let date):
                            print("Successfully created \(date.id)")
                        case .failure(let error):
                            print(error)
                        }
                        return
                    }
                }else{
                    print("账号存在")
                    UserData.shared.userName = date[0].userName ?? "气人小子"
                    UserData.shared.userImage = ""
                }
            case .failure(let error):
                print(error)
            }
            return
        }
    }
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

