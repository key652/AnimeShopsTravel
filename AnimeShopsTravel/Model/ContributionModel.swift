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

class ContributionModel: ContributionDelegate {
    private let alert = AlertCreateView()
    

    
    func sendContentData(userName: String, profileImageData: Data, contentImageData: Data, comment: String, uid: String, viewController: UIViewController) {
        let timeLineDB = Database.database().reference().child("timeLine").childByAutoId()
        let storage = Storage.storage().reference(forURL: "gs://animeshopstravel-5e4c3.appspot.com")
        let profileImageRef = settingImageRef(DB: timeLineDB, storage: storage, child: "Users")
        let contentImageRef = settingImageRef(DB: timeLineDB, storage: storage, child: "Content")
        _ = profileImageRef.putData(profileImageData, metadata: nil) {(metadata, error) in
                if error != nil {
                    self.alert.alertCreate(title: "エラー", message: error!.localizedDescription, actionTitle: "OK", viewCotroller: viewController)
                    return
                }
                _ = contentImageRef.putData(contentImageData, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.alert.alertCreate(title: "エラー", message: error!.localizedDescription, actionTitle: "OK", viewCotroller: viewController)
                    return
                }
                profileImageRef.downloadURL { (profileImageUrl, error) in
                    if error != nil {
                        self.alert.alertCreate(title: "エラー", message: error!.localizedDescription, actionTitle: "OK", viewCotroller: viewController)
                        return
                    }
                    contentImageRef.downloadURL { (contentUrl, error) in
                        if error != nil {
                            self.alert.alertCreate(title: "エラー", message: error!.localizedDescription, actionTitle: "OK", viewCotroller: viewController)
                            return
                        }
                        self.updateChildValues(userName: userName, profileUrl: profileImageUrl!, contentUrl: contentUrl!, comment: comment, uid: uid, Database: timeLineDB)
                        viewController.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    private func updateChildValues(userName:String, profileUrl:URL, contentUrl:URL, comment:String, uid: String, Database: DatabaseReference) {
        let timeLineInfo = ["userName": userName as Any,
                            "profileImage": profileUrl.absoluteString as Any,
                            "contentImage": contentUrl.absoluteString as Any,
                            "comment": comment as Any,
                            "createAt": ServerValue.timestamp() as! [String:Any],
                            "uid": uid as Any]
        Database.updateChildValues(timeLineInfo)
    }
    
    
    private func settingImageRef(DB: DatabaseReference, storage: StorageReference, child: String) -> StorageReference {
        let imageKey = DB.child(child).childByAutoId().key!
        let imageRef = storage.child(child).child("\(String(imageKey)).jpg")
        return imageRef
    }
    
    
}
