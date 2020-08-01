//
//  UserDefalutsModel.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/26.
//  Copyright © 2020 yuma yada. All rights reserved.
//
import Foundation
import UIKit

protocol UserDefaultsDelegate: class {
    func getProfileImageData() -> Data
    func getMyUserName() -> String
    func getMyUid() -> String
    func removeLoginToken()
    func createLoginToken()
    func changeProfileData(userName:String, profileImageData: Data, viewController: UIViewController)
}


class UserDefaultsModel: UserDefaultsDelegate {
    private let alert = AlertCreateView()
    
    func getProfileImageData() -> Data {
        var userprofileImageData: Data!
        if UserDefaults.standard.object(forKey: "profileImageData") != nil {
            userprofileImageData = UserDefaults.standard.object(forKey: "profileImageData") as? Data
        }
        return userprofileImageData
    }
    
    func getMyUserName() -> String {
        var userName :String?
        if UserDefaults.standard.object(forKey: "userName") != nil {
            userName = UserDefaults.standard.object(forKey: "userName")as? String
        }
        let myUserName = userName ?? ""
        return myUserName
    }
    
    func getMyUid() -> String {
        var uid: String?
        if UserDefaults.standard.object(forKey: "uid") != nil {
            uid = UserDefaults.standard.object(forKey: "uid")as? String
        }
        let myUid = uid ?? ""
        return myUid
    }
    
    func createLoginToken() {
        UserDefaults.standard.set(true, forKey: "loginToken")
    }
    
    func removeLoginToken() {
        UserDefaults.standard.removeObject(forKey: "loginToken")
    }
    
    func changeProfileData(userName:String, profileImageData: Data, viewController: UIViewController) {
        if UserDefaults.standard.object(forKey: "userName") != nil {
            UserDefaults.standard.removeObject(forKey: "userName")
        }
        if UserDefaults.standard.object(forKey: "profileImageData") != nil {
            UserDefaults.standard.removeObject(forKey: "profileImageData")
        }
        UserDefaults.standard.set(userName, forKey: "userName")
        UserDefaults.standard.set(profileImageData, forKey: "profileImageData")
        alert.alertCreate(title: "プロフィールを更新しました", message: "", actionTitle: "OK", viewCotroller: viewController)
    }
    
}
