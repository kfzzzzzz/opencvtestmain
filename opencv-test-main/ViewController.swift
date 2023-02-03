//
//  ViewController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 1/15/23.
//

import UIKit
import SnapKit
import Flutter
import FlutterPluginRegistrant

class ViewController: UIViewController {
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("go to Flutter", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        loginButton.addTarget(self, action: #selector(aaaaa), for: .touchUpInside)
        // Do any additional setup after loading the view.
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    
    @objc func aaaaa(){
        print("KFZTESTT:aaaaaaa11")
        let flutterViewController = FlutterViewController(project: nil, initialRoute: "kfz_camera", nibName: nil, bundle: nil)
        self.present(flutterViewController, animated: true, completion: nil)
    }


}

