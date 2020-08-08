//
//  ContributionViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/26.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit
import Firebase
import CropViewController

class ContributionViewController: UIViewController {
    private let alert = AlertCreateView()
    private let myView = ContributionView()
    private var myUid: String!
    private var contentImageData = Data()
    private var profileImageData = Data()
    weak var contributionDelegate: ContributionDelegate?
    private let contributionModel = ContributionModel()
    weak var profileDataDelegate: ProfileDataDelegate?
    private let profileDataModel = ProfileDataModel()
    private var indicator = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.commentTextView.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: true)
        view = myView
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9796229005, blue: 0.9598469873, alpha: 1)
        view.sendSubviewToBack(view)
        setUserData()
        setButtonAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        indicatorSet()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myView.profileImageView.layer.masksToBounds = false
        myView.profileImageView.layer.cornerRadius = myView.profileImageView.frame.width / 2.0
        myView.profileImageView.clipsToBounds = true
    }
    
    
    @objc private func contributionButtonTaped() {
        self.contributionDelegate = contributionModel
        contributionDelegate?.sendContentData(userName: myView.userNameLabel.text!, profileImageData: profileImageData, contentImageData: contentImageData, comment: myView.commentTextView.text, uid: myUid, viewController: self, indicator: indicator)
    }
    
    
    @objc private func cameraButtonTaped() {
        selectContentImage()
    }

    
    @objc private func cancelButtonTaped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myView.commentTextView.resignFirstResponder()
    }
    
    
    private func setUserData() {
        self.profileDataDelegate = profileDataModel
        let user = Auth.auth().currentUser
        profileImageData = profileDataDelegate?.getMyProfileImage() as! Data
        myView.profileImageView.image = UIImage(data: profileImageData)
        myView.userNameLabel.text = user?.displayName
        myUid = user?.uid
    }
    
    
    private func setButtonAction() {
        myView.contributionButton.addTarget(self, action: #selector(contributionButtonTaped), for: .touchUpInside)
        myView.cameraButton.addTarget(self, action: #selector(cameraButtonTaped), for: .touchUpInside)
        myView.cancelButton.addTarget(self, action: #selector(cancelButtonTaped), for: .touchUpInside)
    }
    
    private func indicatorSet() {
        indicator.style = .large
        indicator.color = UIColor.black
        indicator.center = view.center
        view.addSubview(indicator)
    }

    
}



extension ContributionViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let resultText: String = (textView.text as NSString).replacingCharacters(in: range, with: text)
        if resultText.count <= 120 {
            return true
        }
        self.alert.alertCreate(title: "120文字までしか入力できません", message: "", actionTitle: "OK", viewCotroller: self)
        return false
    }
    
}



extension ContributionViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate, CropViewControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let contentImage = info[.originalImage]as? UIImage else { return }
        let cropController = CropViewController(croppingStyle: .default, image: contentImage)
        cropController.delegate = self
        cropController.customAspectRatio = myView.contentImageView.frame.size
        cropController.aspectRatioPickerButtonHidden = true
        cropController.rotateButtonsHidden = true
        cropController.resetButtonHidden = true
        picker.dismiss(animated: true) {
            self.present(cropController, animated: true, completion: nil)
        }
    }
    
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        myView.contentImageView.image = image
        contentImageData = image.jpegData(compressionQuality: 1.0)as! Data
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
    
    
    func selectContentImage(){
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
