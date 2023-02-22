//
//  NoteTestController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/1/23.
//

import UIKit
import SnapKit

class NoteTestController: UIViewController {
    
    private lazy var noteLable : UILabel = {
        let label = UILabel()
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var deleteButton : UIButton = {
        let button = UIButton()
        button.setTitle("delete", for: .normal)
        button.backgroundColor = .red
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var createbutton : UIButton = {
        let button = UIButton()
        button.setTitle("create", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(tapCreateButton), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var querybutton : UIButton = {
        let button = UIButton()
        button.setTitle("query", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(tapQueryButton), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var backbutton : UIButton = {
        let button = UIButton()
        button.setTitle("goBack", for: .normal)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.view.addSubview(button)
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteLable.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(400)
            make.height.equalTo(100)
        }
        createbutton.snp.makeConstraints{ make in
            make.top.equalTo(noteLable.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(100)
        }
        deleteButton.snp.makeConstraints{ make in
            make.top.equalTo(createbutton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(100)
        }
        querybutton.snp.makeConstraints{ make in
            make.top.equalTo(deleteButton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(100)
        }
        backbutton.snp.makeConstraints{ make in
            make.top.equalTo(querybutton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(100)
        }
    }
    
    @objc func tapCreateButton(){
//        let noteData = NoteData(id : UUID().uuidString,
//                                name: "testName",
//                                description: "testDescription")
//        let note = Note(from: noteData)
//        
//        Backend.shared.createNote(note: note)
    }
    
    @objc func tapQueryButton(){
        
        //Backend.shared.queryNotes()

        configLabel()
//        Backend.shared.storeImage(name: "TestFirstPic", image: (UIImage(named: "MainTabIcon")?.pngData())!)
    }
    
    @objc func goBack(){
        
        self.dismiss(animated: false)
    }
    
    func configLabel(){
        
        //self.noteLable.text = "noteNum:\(UserData.shared.notes.count)"
    }
    
}
