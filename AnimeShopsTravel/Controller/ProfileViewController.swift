//
//  ProfileViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/29.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit
import CropViewController

class ProfileViewController: UIViewController {
    private let myView = ProfileView()
    private let userDefaultsModel = UserDefaultsModel()
    private var profileImageData: Data!
    weak var userDefaultsDelegate: UserDefaultsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        view.backgroundColor = UIColor.white
        view.sendSubviewToBack(view)
        myView.userNameTextField.delegate = self
        self.userDefaultsDelegate = userDefaultsModel
        setProfileData()
        myView.changeProfileButton.addTarget(self, action: #selector(changeProfileButtonTaped), for: .touchUpInside)
        addGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myView.profileImageView.layer.masksToBounds = false
        myView.profileImageView.layer.cornerRadius = myView.profileImageView.frame.width / 2.0
        myView.profileImageView.clipsToBounds = true
    }
    
    
    @objc private func changeProfileButtonTaped() {
        guard let userName = myView.userNameTextField.text else { return }
        userDefaultsDelegate?.changeProfileData(userName: userName, profileImageData: profileImageData, viewController: self)
    }
    
    
    @objc private func profileImageViewTaped() {
        selectProfileImage()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myView.userNameTextField.resignFirstResponder()
    }
    
    
    private func setProfileData() {
        myView.userNameTextField.text = userDefaultsDelegate?.getMyUserName()
        profileImageData = userDefaultsDelegate?.getProfileImageData()
        myView.profileImageView.image = UIImage(data: profileImageData)
    }
    
    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTaped))
        myView.profileImageView.addGestureRecognizer(tap)
        myView.profileImageView.isUserInteractionEnabled = true
    }

    
}



extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myView.userNameTextField.resignFirstResponder()
        return true
    }
}



extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let contentImage = info[.originalImage]as? UIImage else { return }
        let cropController = CropViewController(croppingStyle: .default, image: contentImage)
        cropController.delegate = self
        cropController.customAspectRatio = myView.profileImageView.frame.size
        picker.dismiss(animated: true) {
            self.present(cropController, animated: true, completion: nil)
         }
    }
    
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        myView.profileImageView.image = image
        profileImageData = image.jpegData(compressionQuality: 0.1)
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    private func doCamera() {
           let sorceType:UIImagePickerController.SourceType = .camera
           if UIImagePickerController.isSourceTypeAvailable(.camera){
               let cameraPicker = UIImagePickerController()
               cameraPicker.allowsEditing = true
               cameraPicker.sourceType = sorceType
               cameraPicker.delegate = self
               self.present(cameraPicker, animated: true, completion: nil)
           }
       }
    
    
       private func doAlbum(){
           let sorceType:UIImagePickerController.SourceType = .photoLibrary
           if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
               let cameraPicker = UIImagePickerController()
               cameraPicker.allowsEditing = true
               cameraPicker.sourceType = sorceType
               cameraPicker.delegate = self
               self.present(cameraPicker,animated: true, completion: nil)
           }
    }
    
    
    private func selectProfileImage(){
         let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
         let camera = UIAlertAction(title: "カメラ", style: .default) { (alert) in
             self.doCamera()
         }
         let album = UIAlertAction(title: "アルバム", style: .default) { (alert) in
             self.doAlbum()
         }
         let cancel = UIAlertAction(title: "キャンセル", style: .cancel)
         alertController.addAction(camera)
         alertController.addAction(album)
         alertController.addAction(cancel)
         present(alertController, animated: true,completion: nil)
     }
    
    
}
