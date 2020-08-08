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
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9796229005, blue: 0.9598469873, alpha: 1)
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
        setUpNotificationForButton()
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
    
    private func setUpNotificationForButton() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]as! NSValue).cgRectValue
        let keyboardOriginY = view.frame.size.height - keyboardSize.height
        let changeProfileButtonOriginY = myView.changeProfileButton.frame.origin.y
        if keyboardOriginY < changeProfileButtonOriginY {
            myView.changeProfileButtonConstraint?.constant = -(view.frame.size.height - keyboardOriginY)
        }
    }
    
    
    @objc private func keyboardWillHide(notification: Notification) {
        myView.changeProfileButtonConstraint?.constant = -159
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
        cropController.aspectRatioPickerButtonHidden = true
        cropController.resetButtonHidden = true
        cropController.rotateButtonsHidden = true
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
