//
//  SettingViewController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/27/23.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    private lazy var  avatarView : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.pink1()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.pink1().cgColor
        imageView.image = UserData.shared.userImage
        self.view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var nameTextView : UITextField = {
        let field = UITextField()
        field.textContentType = .username
        field.autocapitalizationType = .none  //自动大写样式
        field.autocorrectionType = .no //自动更正样式
        field.returnKeyType = .continue //返回键可视
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "请输入用户名"
        field.text = UserData.shared.userName
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        self.view.addSubview(field)
        return field
    }()
    
    private lazy var confirmButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.pink1()
        button.setTitle("保存", for: .normal)
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("取消", for: .normal)
        button.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
        avatarView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100.atScale())
            make.height.width.equalTo(80.atScale())
        }
        nameTextView.snp.makeConstraints{ make in
            make.top.equalTo(avatarView.snp.bottom).offset(40.atScale())
            make.centerX.equalToSuperview()
            make.width.equalTo(200.atScale())
            make.height.equalTo(50.atScale())
        }
        confirmButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-100.atScale())
            make.left.equalTo(nameTextView)
            make.height.equalTo(40.atScale())
            make.width.equalTo(70.atScale())
        }
        cancelButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-100.atScale())
            make.right.equalTo(nameTextView)
            make.height.equalTo(40.atScale())
            make.width.equalTo(70.atScale())
        }
        
        //Add Gesture
        avatarView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(avatarViewTapped))
        avatarView.addGestureRecognizer(gesture)
    }
    
    @objc func tapCancelButton(){
        self.dismiss(animated: false)
    }
    
    @objc private func avatarViewTapped(){
        print("KFZTEST:avatarViewTapped")
        presentPhotoActionSheet()
    }
    
    // MARK: - public
    func show(above viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController,
              completion: (() -> Void)? = nil) {
        print(viewController)
        viewController?.present(self, animated: true, completion: completion)
    }
    
}

extension SettingViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = SettingPresentationController(presentedViewController: presented, presenting: presenting)
        return vc
    }

}

extension SettingViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile picture", message: "How would likt to select a picture?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: {[weak self] _ in self?.presentCamera()}))
        actionSheet.addAction(UIAlertAction(title: "Chose photo", style: .default, handler: {[weak self] _ in self?.presentPhotoPicker()}))
        
        present(actionSheet,animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = . photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated:true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print(info)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        
        self.avatarView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
