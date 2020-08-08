//
//  ProfileDataModel.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/08/09.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol ProfileDataDelegate: class {
    func getMyProfileImage() -> Data
    func changeProfileData(name: String, profileImageData: Data, viewController: UIViewController)
}

class ProfileDataModel: ProfileDataDelegate {
    private let alert = AlertCreateView()
    
    func changeProfileData(name: String, profileImageData: Data, viewController: UIViewController) {
        if UserDefaults.standard.object(forKey: "profileImageData") != nil {
            UserDefaults.standard.removeObject(forKey: "profileImageData")
        }
        UserDefaults.standard.set(profileImageData, forKey: "profileImageData")
        let user = Auth.auth().currentUser?.createProfileChangeRequest()
        user?.displayName = name
        user?.commitChanges(completion: { (error) in
            if error != nil {
                self.alert.alertCreate(title: "エラー", message: error!.localizedDescription, actionTitle: "OK", viewCotroller: viewController)
                return
            }
        })
        alert.alertCreate(title: "変更が完了しました", message: "", actionTitle: "OK", viewCotroller: viewController)
    }
    
    
    func getMyProfileImage() -> Data {
        var profileImageData: Data!
        if UserDefaults.standard.object(forKey: "profileImageData") != nil {
            profileImageData = UserDefaults.standard.object(forKey: "profileImageData")as? Data
        }
        return profileImageData
    }
    
    
    
    
}
