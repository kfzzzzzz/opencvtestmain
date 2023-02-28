//
//  SettingViewController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/27/23.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class SettingViewController: UIViewController {
    
    private lazy var activityIndicatorView : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRectMake(0, 0,         UIScreen.main.bounds.width*0.8,UIScreen.main.bounds.height*0.4))
        view.style = UIActivityIndicatorView.Style.large
        view.color = .pink1()
        view.hidesWhenStopped = true
        self.view.addSubview(view)
        return view
    }()
    
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
        field.returnKeyType = .done //返回键可视
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
        button.layer.cornerRadius = 8.atScale()
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(tapConfirmButton), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("取消", for: .normal)
        button.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        button.layer.cornerRadius = 8.atScale()
        button.layer.masksToBounds = true
        self.view.addSubview(button)
        return button
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = .white
        avatarView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40.atScale())
            make.height.width.equalTo(80.atScale())
        }
        nameTextView.snp.makeConstraints{ make in
            make.top.equalTo(avatarView.snp.bottom).offset(40.atScale())
            make.centerX.equalToSuperview()
            make.width.equalTo(200.atScale())
            make.height.equalTo(50.atScale())
        }
        confirmButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-40.atScale())
            make.left.equalTo(nameTextView)
            make.height.equalTo(40.atScale())
            make.width.equalTo(70.atScale())
        }
        cancelButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-40.atScale())
            make.right.equalTo(nameTextView)
            make.height.equalTo(40.atScale())
            make.width.equalTo(70.atScale())
        }
        
        //Add Gesture
        avatarView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(avatarViewTapped))
        avatarView.addGestureRecognizer(gesture)
        
        nameTextView.delegate = self
    }
    
    @objc func tapConfirmButton(){
        activityIndicatorView.startAnimating()
        if nameTextView.text != UserData.shared.userName {

        }
        if avatarView.image != UserData.shared.userImage {

        }
        
    }
    
    @objc func tapCancelButton(){
        self.dismiss(animated: true)
    }
    
    @objc private func avatarViewTapped(){
        print("KFZTEST:avatarViewTapped")
        presentPhotoActionSheet()
    }
    
     //MARK: - public
    func show() {
        let vc = UIViewController.getCurrentViewController()
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
        vc?.present(self, animated: true)
    }

}

extension SettingViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = SettingPresentationController(presentedViewController: presented, presenting: presenting)
        return vc
    }
}

extension SettingViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SettingViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "头像", message: "选个气人的头像", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "不选了", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "拍个照片", style: .default, handler: {[weak self] _ in self?.presentCamera()}))
        actionSheet.addAction(UIAlertAction(title: "回忆中选", style: .default, handler: {[weak self] _ in self?.presentPhotoPicker()}))
        
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
