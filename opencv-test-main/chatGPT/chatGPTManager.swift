//
//  chatGPTManager.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 3/16/23.
//

import OpenAISwift
import UIKit

class chatGPTManager: NSObject {
    
    static let shared = chatGPTManager()
    
    private var openAI = OpenAISwift(authToken: "")
    
    private var isInit = false
    
    private var key = ""{
        didSet{
            self.openAI = OpenAISwift(authToken: key)
        }
    }
    
    override init() {
        super.init()
        AccountManager.shared.retrieveImage(name: "GPTKEY.txt") { [self] (data) in
            if let string = String(data: data, encoding: .utf8) {
                self.key = string
                self.isInit = true
            } else {
                print("无法将Data数据转换成String")
            }
        }
    }
    
    
    func sendMessageToGPT(inputText : String, completion: ((String) -> Void)?) {
        openAI.sendCompletion(with: inputText,model: .gpt3(.davinci) ,maxTokens: 500) { result in // Result<OpenAI, OpenAIError>
            switch result {
            case .success(let success):
                print("KFZTEST:GPT:\(success.choices.first?.text ?? "")")
                completion?(success.choices.first?.text ?? "")
            case .failure(let failure):
                completion?(failure.localizedDescription)
            }
        }
    }
    
    func chatGPT35(inputText : String, completion: ((String) -> Void)?) async {
        do {
            let chat: [ChatMessage] = [
                ChatMessage(role: .user, content: inputText)
            ]
            
            if self.isInit == false {
                completion?("没有初始化")
            }
                        
            let result = try await openAI.sendChat(with: chat)
            completion?(result.choices.first?.message.content.trimmingCharacters(in: .newlines) ?? "Nothing")
            print(result.choices.first?.message.content.trimmingCharacters(in: .newlines) ?? "Nothing")
        } catch {
            completion?("Something went wrong")
            print("Something went wrong")
        }
    }
    
}
