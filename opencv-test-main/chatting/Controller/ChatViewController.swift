//
//  ChatViewController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/28/23.
//

import Foundation
import UIKit
import SnapKit
import Toast_Swift

class ChatViewController: UIViewController{
    
    private var chatViewModel = ChatViewModel()
    
    private lazy var textEditField : inputTextView = {
        let view = inputTextView()
        self.view.addSubview(view)
        return view
    }()
    
//    private lazy var textEditField : UITextField = {
//        let field = UITextField()
//        field.textContentType = .username
//        field.autocapitalizationType = .none  //自动大写样式
//        field.autocorrectionType = .no //自动更正样式
//        field.returnKeyType = .send //返回键可视
//        field.layer.cornerRadius = 12
//        field.layer.borderWidth = 1
//        field.layer.borderColor = UIColor.lightGray.cgColor
//        field.placeholder = "----------------开始气人-----------------"
//        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
//        field.leftViewMode = .always
//        field.backgroundColor = .white
//        self.view.addSubview(field)
//        return field
//    }()
    
    private lazy var messageTable : UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.isScrollEnabled = true
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        table.autoresizesSubviews = false
        table.register(messageListCell.self, forCellReuseIdentifier: "messageListCell")
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        if #available(iOS 13.0, *) {
            table.automaticallyAdjustsScrollIndicatorInsets = false
        }else {
            // Fallback on earlier versions
        }
        self.view.addSubview(table)
        return table
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        chatViewModel.delegate = self
        textEditField.delegate = self
        messageTable.delegate = self
        messageTable.dataSource = self
        textEditField.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(10.atScale())
            make.right.equalToSuperview().offset(-10.atScale())
            make.height.equalTo(40.atScale())
        }
        messageTable.snp.makeConstraints{ make in
            make.top.equalTo(textEditField.snp.bottom).offset(10.atScale())
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.chatViewModel.getChatRoom(){
            DispatchQueue.main.async() {
                self.messageTable.reloadData()
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          tapGesture.cancelsTouchesInView = false
          view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.chatViewModel.getRealTimeMessage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.chatViewModel.stopGetMessage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ChatViewController: ChatViewModelDelegate {
    func updateDate() {
        DispatchQueue.main.async() {
            self.messageTable.reloadData()
        }
    }
}

extension ChatViewController : UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            if !textView.text!.isEmpty{
                textView.resignFirstResponder()
                chatViewModel.sendMessage(body: textView.text!){
                    textView.text = ""
                }
            }else{
                textView.text = ""
            }
        }
        return true
    }
        
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatViewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageListCell", for: indexPath) as! messageListCell
        let senderImage = (chatViewModel.messages[indexPath.row].senderId ?? "-1") + ".jpg"
        let avater = chatViewModel.usersAvatar[senderImage]
        if avater != nil{
            cell.setData(message: chatViewModel.messages[indexPath.row], avatar: avater!)
        } else {
            cell.setData(message: chatViewModel.messages[indexPath.row], avatar: UIImage(named: "avatarPlaceholder") ?? UIImage())
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.atScale()
    }
    
}
