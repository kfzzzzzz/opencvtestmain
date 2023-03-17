//
//  chatGPTViewController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 3/16/23.
//

import NVActivityIndicatorView

import Foundation
import UIKit
import SnapKit
import Toast_Swift

class chatGPTViewController: UIViewController{
    
    typealias chatMessage = (String, String)
    private var messageList : [chatMessage] = []
    
    private lazy var activityIndicatorView : NVActivityIndicatorView = {
            let view = NVActivityIndicatorView(frame: CGRectMake(0, 0,         UIScreen.main.bounds.width,UIScreen.main.bounds.height), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.pink1(),padding: 300.atScale())
            self.view.addSubview(view)
            return view
        }()
    
    private lazy var textEditField : UITextField = {
        let field = UITextField()
        field.textContentType = .username
        field.autocapitalizationType = .none  //自动大写样式
        field.autocorrectionType = .no //自动更正样式
        field.returnKeyType = .send //返回键可视
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "----------------开始气人-----------------"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        self.view.addSubview(field)
        return field
    }()
    
    private lazy var messageTable : UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.isScrollEnabled = true
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        table.autoresizesSubviews = false
        table.register(chatGPTTableCell.self, forCellReuseIdentifier: "chatGPTTableCell")
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        textEditField.delegate = self
        messageTable.delegate = self
        messageTable.dataSource = self
        textEditField.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(10.atScale())
            make.right.equalToSuperview().offset(-10.atScale())
            make.height.equalTo(30.atScale())
        }
        messageTable.snp.makeConstraints{ make in
            make.top.equalTo(textEditField.snp.bottom).offset(10.atScale())
            make.bottom.left.right.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension chatGPTViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if UserData.shared.isSignedIn == false{
            self.view.makeToast("气死了，先登录再气人！")
            return true
        }
        if !textField.text!.isEmpty{
            let inputString = textField.text!
            textField.text = ""
            messageList = messageList.reversed()
            messageList.append(("user", inputString))
            messageList = messageList.reversed()
            self.messageTable.reloadData()
            activityIndicatorView.startAnimating()
//            chatGPTManager.shared.sendMessageToGPT(inputText: inputString) { result in
//                self.messageList = self.messageList.reversed()
//                self.messageList.append(("GPT", result))
//                self.messageList = self.messageList.reversed()
//                DispatchQueue.main.async() {
//                    self.messageTable.reloadData()
//                    self.activityIndicatorView.stopAnimating()
//                }
//            }
            Task.init(priority: .medium) {
                await chatGPTManager.shared.chatGPT35(inputText: inputString, completion: { result in
                    self.messageList = self.messageList.reversed()
                    self.messageList.append(("GPT", result))
                    self.messageList = self.messageList.reversed()
                    DispatchQueue.main.async() {
                        self.messageTable.reloadData()
                        self.activityIndicatorView.stopAnimating()
                    }
                })
            }
        }
        return true
    }
}

extension chatGPTViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatGPTTableCell", for: indexPath) as! chatGPTTableCell
        if messageList[indexPath.row].0 == "user" {
            cell.setData(text: messageList[indexPath.row].1, type: .user)
        }else{
            cell.setData(text: messageList[indexPath.row].1, type: .chatGPT)
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
