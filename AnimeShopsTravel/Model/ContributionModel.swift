//
//  ContributionModel.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/26.
//  Copyright © 2020 yuma yada. All rights reserved.
//
import Foundation
import Firebase

protocol ContributionDelegate: class {
    func sendContentData(userName: String,profileImageData: Data, contentImageData: Data, comment: String, uid: String, viewController: UIViewController)
}

class Contribution: ContributionDelegate {
    private let alert = AlertCreateView()
    

    
    func sendContentData(userName: String, profileImageData: Data, contentImageData: Data, comment: String, uid: String, viewController: UIViewController) {
        let timeLineDB = Database.database().reference().child("timeLine").childByAutoId()
        let storage = Storage.storage().reference(forURL: "gs://animeshopstravel-5e4c3.appspot.com")
        let profileImageRef = settingImageRef(DB: timeLineDB, storage: storage, child: "Users")
        let contentImageRef = settingImageRef(DB: timeLineDB, storage: storage, child: "Content")
            let uploadTask = profileImageRef.putData(profileImageData, metadata: nil) {(metadata, error) in
                if error != nil {
                    self.alert.alertCreate(title: "エラー", message: "\(String(describing: error))", actionTitle: "OK", viewCotroller: viewController)
                    return
                }
            let uploadTask2 = contentImageRef.putData(contentImageData, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.alert.alertCreate(title: "エラー", message: "\(String(describing: error))", actionTitle: "OK", viewCotroller: viewController)
                    return
                }
                profileImageRef.downloadURL { (profileImageUrl, error) in
                    if error != nil {
                        self.alert.alertCreate(title: "エラー", message: "\(String(describing: error))", actionTitle: "OK", viewCotroller: viewController)
                        return
                    }
                    contentImageRef.downloadURL { (contentUrl, error) in
                        if error != nil {
                            self.alert.alertCreate(title: "エラー", message: "\(String(describing: error))", actionTitle: "OK", viewCotroller: viewController)
                            return
                        }
                        let timeLineInfo = ["userName": userName as Any,
                                            "profileImage": profileImageUrl?.absoluteString as Any,
                                            "contentImage": contentUrl?.absoluteString as Any,
                                            "comment": comment as Any,
                                            "createAt": ServerValue.timestamp() as! [String:Any],
                                            "uid": uid as Any]
                        timeLineDB.updateChildValues(timeLineInfo)
                        viewController.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    
    // プロフィール画像と投稿画像をFirebaseのStorageに送ります
    private func sendImageData(profileImageRef: StorageReference, contentImageRef: StorageReference,profileImageData: Data, contentImageData: Data, viewController: UIViewController) {
        let uploadTask = profileImageRef.putData(profileImageData, metadata: nil) {(metadata, error) in
            if error != nil {
                self.alert.alertCreate(title: "エラー", message: "\(String(describing: error))", actionTitle: "OK", viewCotroller: viewController)
                return
            }
        }
        let uploadTask2 = contentImageRef.putData(contentImageData, metadata: nil) { (metadata, error) in
            if error != nil {
                self.alert.alertCreate(title: "エラー", message: "\(String(describing: error))", actionTitle: "OK", viewCotroller: viewController)
                return
            }
        }
    }
    
    
    
    private func settingImageRef(DB: DatabaseReference, storage: StorageReference, child: String) -> StorageReference {
        let imageKey = DB.child(child).childByAutoId().key!
        let imageRef = storage.child(child).child("\(String(imageKey)).jpg")
        return imageRef
    }
    
    
}
