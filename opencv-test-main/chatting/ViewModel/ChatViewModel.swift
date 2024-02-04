//
//  ChatViewModel.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 3/1/23.
//

import Foundation
import Amplify
import Combine

protocol ChatViewModelDelegate : AnyObject {
    func updateDate()
}

class ChatViewModel {
    
    weak var delegate : ChatViewModelDelegate?
    var messages: [Message] = []
    var chatRoom: ChatRoom?
    var getMessage: AnyCancellable?
    var usersAvatar : [String : UIImage] = [UserData.shared.userImageURL : UserData.shared.userImage ?? UIImage()]
    //var nowSender : UserModel?
    
    func getChatRoom(completed: @escaping () -> Void){
        Amplify.DataStore.query(ChatRoom.self){ result in
            switch result{
            case .success(let date):
                if date.isEmpty {
                    print("未找到聊天室")
                    completed()
                }else{
                    print("加入聊天室\( date[0].id)")
                    self.chatRoom = date[0]
                    self.messages = date[0].Messages!.elements
                    self.messages.sort(by: sortMessage)
                    if self.messages.count == 0 {
                        return
                    }
//                    for index in 0...self.messages.count - 1{
//                        let senderId = self.messages[index].messageSenderId
//                        self.getSender(id: senderId ?? "-1" ){ user in
//                            self.messages[index].sender = user!
//                        }
//                    }
                    
                    // 获取头像
                    for index in 0...self.messages.count - 1{
                        let senderImage = (self.messages[index].senderId ?? "-1") + ".jpg"
                        if self.usersAvatar[senderImage] == nil && senderImage != "-1.jpg"{
                            self.usersAvatar[senderImage] = UIImage()
                            AccountManager.shared.retrieveData(name: senderImage) { result in
                                switch result{
                                case .failure(let error):
                                    print(error)
                                case .success(let data):
                                    self.usersAvatar[senderImage] = UIImage(data: data)
                                }
                            }
                        }
                        completed()
                    }

                    
                    func sortMessage(message1 : Message , message2 : Message)-> Bool {
                        return message1.dateTime! > message2.dateTime!
                    }
                    completed()
                }
            case .failure(let error):
                print(error)
            }
            return
        }
        
    }
    
    func getAvater(senderImage : String){
        if self.usersAvatar[senderImage] == nil && senderImage != "-1.jpg"{
            self.usersAvatar[senderImage] = UIImage()
            AccountManager.shared.retrieveData(name: senderImage) { result in
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.usersAvatar[senderImage] = UIImage(data: data)
                }
            }
        }
    }
    
    
    func createChatRoom(completed: @escaping () -> Void){
        Amplify.DataStore.save(ChatRoom(memberIds: ["MANYPEOPLE"],Messages: [])){ result in
            switch result{
            case .success(let date):
                print("新创建聊天室: \(date.id)")
                self.chatRoom = date
                completed()
            case .failure(let error):
                print(error)
            }
            return
        }
    }
    
//    func userIntoChatRoom(){
//        var newmembers = memberIds
//        newmembers.append(UserData.shared.id)
//        Amplify.DataStore.save(ChatRoom(id: chatroomId, memberIds: newmembers, Messages: [])){ result in
//            switch result{
//            case .success(let date):
//                print("新用户加入聊天室: \(date.id)")
//            case .failure(let error):
//                print(error)
//            }
//            return
//        }
//    }

    /// 获取实时信息
    func getRealTimeMessage() {
        
        self.getMessage = Amplify.DataStore.observeQuery(
            for: Message.self,
            where: Message.keys.chatroomID == chatRoom?.id
        )
        .sink { completed in
            switch completed {
            case .finished:
                print("finished")
            case .failure(let error):
                print("Error \(error)")
            }
        } receiveValue: { querySnapshot in
            self.messages = querySnapshot.items
            self.messages.sort(by: sortMessage)
            if self.messages.count == 0 {
                return
            }
//            for index in 0...self.messages.count - 1{
//                let senderId = self.messages[index].messageSenderId
//                self.getSender(id: senderId ?? "-1" ){ user in
//                    self.messages[index].sender = user!
//                }
//            }
            func sortMessage(message1 : Message , message2 : Message)-> Bool {
                return message1.dateTime! > message2.dateTime!
            }
            self.delegate?.updateDate()
            print("[Snapshot] item count: \(querySnapshot.items.count), isSynced: \(querySnapshot.isSynced)")
        }
    }

    // Then, when you're finished observing, cancel the subscription
    func stopGetMessage() {
        getMessage?.cancel()
    }
    
    /// 发送消息
    func sendMessage(body: String, completed: @escaping () -> Void){
        //let message = Message(body: body, dateTime: .now(), chatroomID: chatRoom?.id ?? "-1", sender: self.nowSender!, messageSenderId: self.nowSender!.id)
        let message = Message(body: body, dateTime: .now(), chatroomID: chatRoom?.id ?? "-1", senderName: UserData.shared.userName, senderId: UserData.shared.userId)
        Amplify.DataStore.save(message){ result in
            switch result{
            case .success(let date):
                print("成功发送消息 \(date)")
                completed()
            case .failure(let error):
                print("消息发送失败 \(error)")
                return
            }
        }
    }
    
//    func getTestMessage(){
//        Amplify.DataStore.query(Message.self){ result in
//            switch result{
//            case .success(let date):
//                if let messageWithUser = date {
//                    if let comments = messageWithUser {
////                        for comment in comments {
////                            print(comment.content)
////                        }
//                    }
//                } else {
//                    print("Post not found")
//                }
//            case .failure(let error):
//                print("KFZTEST:getTestMessage:\(error)")
//                return
//            }
//        }
//    }
    
    func getSender(id: String, completed: @escaping (UserModel?) -> Void){
        Amplify.DataStore.query(UserModel.self, byId: id){ result in
            switch result{
            case .success(let date):
                completed(date)
            case .failure(let error):
                print("获得发送人失败 \(error)")
                return
            }
        }
    }
    
//    func getNowSender(retryCount : Int = 0){
//        Amplify.DataStore.query(UserModel.self, where: UserModel.keys.UserPhoneNumber == UserData.shared.userPhoneNumber){ result in
//            switch result{
//            case .success(let date):
//                if retryCount < 5 && date.first == nil{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                        print("查找\(UserData.shared.userPhoneNumber)失败尝试\(retryCount)次")
//                        self.getNowSender(retryCount: retryCount+1)
//                    }
//                }
//                self.nowSender = date.first
//            case .failure(let error):
//                if retryCount < 5 {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                        self.getNowSender(retryCount: retryCount+1)
//                    }
//                } else {
//                    print("查找失败超过5次\(error)")
//                }
//                return
//            }
//        }
//    }
    
    func deleteMessage(){
        Amplify.DataStore.query(Message.self) { result in
            switch result {
            case .success(let items):
                if self.messages.count == 0 {
                    return
                }
                for index in 0...items.count - 1{
                    // 删除模型下的所有数据
                    Amplify.DataStore.delete(items[index], completion: { result in
                        switch result {
                        case .success:
                            print("模型下的所有数据已成功删除")
                        case .failure(let error):
                            print("删除数据时出现错误： \(error.localizedDescription)")
                        }
                    })
                }
            case .failure(let error):
                print("查询数据时出现错误： \(error.localizedDescription)")
            }
        }
    }
        
    
}
