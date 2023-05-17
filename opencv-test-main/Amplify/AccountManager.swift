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

    }
    
    public func fetchAuthSession(completed: @escaping (Bool) -> Void){
        _ = Amplify.Auth.fetchAuthSession { (result) in
            do {
                let session = try result.get()
                self.updateUserData(withSignInStatus: session.isSignedIn) { _ in
                    completed(session.isSignedIn)
                }
            } catch {
                print("Fetch auth session failed with error - \(error)")
            }
        }
    }
    
    //注册用户
    public func signUp(username: String, password: String, email: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }
    
    //验证用户注册
    func confirmSignUp(for username: String, with confirmationCode: String, completed: @escaping (Bool) -> Void) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
                completed(true)
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
                completed(false)
            }
        }
    }
    
    // 重新发送验证码
    func resendConfirmCode(username: String) {
        Amplify.Auth.resendSignUpCode(for: username){ result in
            switch result{
            case .success(_):
                print("重新发送验证码成功")
            case .failure(_):
                print("重新发送验证码失败")
            }
        }
    }
    
    
    //登录用户
    public func signIn(username: String, password: String) {
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .success:
                print("Sign in succeeded")
            case .failure(let error):
                print("Sign in failed \(error)")
            }
        }
    }
    
    //确认用户登录成功
    public func confirmSignIn() {
        Amplify.Auth.confirmSignIn(challengeResponse: "<confirmation code received via SMS>") { result in
            switch result {
            case .success(let signInResult):
                print("Confirm sign in succeeded. Next step: \(signInResult.nextStep)")
            case .failure(let error):
                print("Confirm sign in failed \(error)")
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
                
                DispatchQueue.main.async {
                    if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
                        navigationController.popToRootViewController(animated: false)
                    }
                    let loginViewController = XTLoginViewController()
                    let navigationController = UINavigationController(rootViewController: loginViewController)
                    navigationController.isNavigationBarHidden = true
                    UIApplication.shared.windows.first?.rootViewController = navigationController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
                
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    //更新用户属性
    public func updateAttribute(attribute: [AuthUserAttribute], completed: (() -> Void)? = nil) {
        Amplify.Auth.update(userAttributes: attribute) { result in
            switch result {
            case .failure(let error):
                print(error)
                completed?()
            case .success(_):
                self.updateUserData(withSignInStatus: true)
                completed?()
            }
        }
//        Amplify.Auth.update(userAttribute: attribute) { result in
//            do {
//                let updateResult = try result.get()
//                switch updateResult.nextStep {
//                case .confirmAttributeWithCode(let deliveryDetails, let info):
//                    print("Confirm the attribute with details send to - \(deliveryDetails) \(info)")
//                    completed?()
//                case .done:
//                    print("Update completed")
//                    self.updateUserData(withSignInStatus: true)
//                    completed?()
//                }
//            } catch {
//                print("Update attribute failed with error \(error)")
//                completed?()
//            }
//        }
    }

    func updateUserData(withSignInStatus status: Bool, completed: ((Bool) -> Void)? = nil) {
        DispatchQueue.main.async() {
            UserData.shared.isSignedIn = status
            if status {
                UserData.shared.userId = Amplify.Auth.getCurrentUser()?.userId ?? "-1"
                Amplify.Auth.fetchUserAttributes() { result in
                    switch result {
                    case .success(let attributes):
                        UserData.shared.userName = attributes.first(where: { $0.key == .name })?.value ?? "气人小子"
                        UserData.shared.userPhoneNumber = attributes.first(where: { $0.key == .phoneNumber })?.value ?? ""
                        UserData.shared.userImageURL = attributes.first(where: { $0.key == .picture })?.value ?? ""
                        self.retrieveImage(name: UserData.shared.userImageURL) { result in
                            switch result {
                            case let .success(data):
                                UserData.shared.userImage = UIImage(data: data)
                            case .failure(_):
                                UserData.shared.userImage = UIImage(named: "avatarPlaceholder")
                            }
                            NotificationCenter.default.post(name: Notification.Name.updateUserData, object: nil)
                            self.delegate?.updateUserInfo()
                            completed?(true)
                        }
                    case .failure(let error):
                        print("获取用户信息失败:\(error)")
                        completed?(false)
                    }
                }
            } else {
                UserData.shared.clear()
                NotificationCenter.default.post(name: Notification.Name.updateUserData, object: nil)
                self.delegate?.updateUserInfo()
                completed?(true)
            }
        }
    }
    
    // MARK: - Image Storage
    
    func storeImage(name: String, image: Data, completed: @escaping () -> Void) {
        
        //        let options = StorageUploadDataRequest.Options(accessLevel: .private)
        let _ = Amplify.Storage.uploadData(key: name, data: image,// options: options,
                                           progressListener: { progress in
            // optionlly update a progress bar here
        }, resultListener: { event in
            switch event {
            case .success(let data):
                print("Image upload completed: \(data)")
                completed()
            case .failure(let storageError):
                print("Image upload failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        })
    }
    
    func retrieveImage(name: String, completed: @escaping (Result<Data, Error>) -> Void) {
        let _ = Amplify.Storage.downloadData(key: name,
                                             progressListener: { progress in
        }, resultListener: { (event) in
            switch event {
            case let .success(data):
                print("图片 \(name) 加载成功")
                completed(.success(data))
            case let .failure(storageError):
                print("无法加载图片: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                completed(.failure(storageError))
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
    
    func fetchUserAttributes(key : AuthUserAttributeKey, completed: @escaping (String?) -> Void){
        Amplify.Auth.fetchUserAttributes() { result in
            switch result {
            case .success(let attributes):
                if let singleAttribute = attributes.first(where: { $0.key == key }) {
                    completed(singleAttribute.value)
                } else {
                    completed(nil)
                }
            case .failure(_):
                completed(nil)
            }
        }
    }
    
//    func signInUserModelCheck(retryCount: Int = 0, completed: @escaping () -> Void){
//        Amplify.Auth.fetchUserAttributes() { result in
//            switch result {
//            case .success(let attributes):
//                let phoneNumber = attributes.first(where: { $0.key == .phoneNumber })?.value ?? ""
//                let name = attributes.first(where: { $0.key == .name })?.value ?? ""
//                let picture = attributes.first(where: { $0.key == .picture })?.value ?? ""
//                Amplify.DataStore.query(UserModel.self, where: UserModel.keys.UserPhoneNumber == phoneNumber) {
//                    switch $0 {
//                    case .success(let date):
//                        if retryCount < 3 && date.first == nil{
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                                print("查找用户\(retryCount)次")
//                                self.signInUserModelCheck(retryCount: retryCount + 1){
//                                    completed()
//                                }
//                            }
//                        }else if retryCount >= 3 && date.first == nil{
//                            print("创建新用户")
//                            self.regirestUserModel(userModel: UserModel(UserPhoneNumber: phoneNumber, UserName: name, UserImage: picture))
//                            completed()
//                        }else{
//                            print("用户存在\(phoneNumber)")
//                            completed()
//                        }
//                    case .failure(_):
//                        if retryCount < 3 {
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                                print("查找用户\(retryCount)次")
//                                self.signInUserModelCheck(retryCount: retryCount + 1){}
//                            }
//                        }
//                    }
//                }
//            case .failure(let error):
//                print("失败失败失败\(error)")
//            }
//        }
//    }
    
    func regirestUserModel(userModel : UserModel){
        Amplify.DataStore.save(userModel) {
            switch $0 {
            case .success:
                print("Created a new userModel successfully")
            case .failure(let error):
                print("Error creating userModel - \(error.localizedDescription)")
            }
        }
    }
    
//    func updateUserModel(userModel : UserModel, retryCount: Int = 0){
//        Amplify.DataStore.query(UserModel.self, where: UserModel.keys.UserPhoneNumber == userModel.UserPhoneNumber) {
//            switch $0 {
//            case .success(let result):
//                var existingUserModel: UserModel = result.first!
//                existingUserModel.UserPhoneNumber = userModel.UserPhoneNumber
//                existingUserModel.UserName = userModel.UserName
//                existingUserModel.UserImage = userModel.UserImage
//
//                Amplify.DataStore.save(existingUserModel) {
//                    switch $0 {
//                    case .success:
//                        print("Updated the UserModel")
//                    case .failure(let error):
//                        print("Error updating UserModel - \(error.localizedDescription)")
//                    }
//                }
//            case .failure(let error):
//                if retryCount < 3 {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                        self.updateUserModel(userModel: userModel, retryCount: retryCount + 1)
//                    }
//                } else {
//                    print("查找失败超过5次\(error)")
//                }
//            }
//        }
//    }
    
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
    
    /// 用户信息刷新
    static let updateUserData = Notification.Name("updateUserData")
}

