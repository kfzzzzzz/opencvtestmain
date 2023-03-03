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
    var nowUser = UserTest(id: UserData.shared.id, userName: UserData.shared.userName, userId: UserData.shared.userId, userImage: UserData.shared.userImageURL)
    var getMessage: AnyCancellable?
    var usersAvatar : [String : UIImage] = [:]
    
    func getChatRoom(completed: @escaping () -> Void){
        Amplify.DataStore.query(ChatRoom.self){ result in
            switch result{
            case .success(let date):
                if date.isEmpty {
//                    self.createChatRoom(){
//                        print("创建新聊天室\(date)")
//                        completed()
//                    }
                    print("未找到聊天室")
                    completed()
                }else{
                    print("加入聊天室\( date[0].id)")
                    self.chatRoom = date[0]
                    self.messages = date[0].Messages!.elements
                    for index in 0...self.messages.count - 1{
                        let senderId = self.messages[index].messageSenderId
                        self.getSender(id: senderId ?? "-1"){ user in
                            self.messages[index].sender = user
                        }
                    }
                    self.messages.sort(by: sortMessage)
                    
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
            for index in 0...self.messages.count - 1{
                let senderId = self.messages[index].messageSenderId
                self.getSender(id: senderId ?? "-1"){ user in
                    self.messages[index].sender = user
                }
            }
            self.messages.sort(by: sortMessage)
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
        let message = Message(body: body, sender:nowUser, dateTime: .now(),chatroomID: chatRoom?.id ?? "-1",messageSenderId: nowUser.id)
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
    
    func getSender(id: String, completed: @escaping (UserTest?) -> Void){
        Amplify.DataStore.query(UserTest.self, byId: id){ result in
            switch result{
            case .success(let date):
                completed(date)
            case .failure(let error):
                print("获得发送人失败 \(error)")
                return
            }
        }
    }
        
    
}
