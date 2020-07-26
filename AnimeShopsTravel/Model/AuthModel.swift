//
//  AuthModel.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import Firebase


protocol AuthDelegate: class {
    func login(email: String, password: String, viewController: UIViewController)
    func resetPassword()
    func singup(email: String, password: String, name: String, viewController: UIViewController)
}



class AuthModel: AuthDelegate {
    private let alert = AlertCreateView()
    
    
    func login(email: String, password: String, viewController: UIViewController) {
        if email == "" || password == "" {
            alert.alertCreate(title: "入力されていない項目があります。", message: "", actionTitle: "OK", viewCotroller: viewController)
        }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.alert.alertCreate(title: "メールアドレスまたはパスワードが間違っています。", message: "", actionTitle: "OK", viewCotroller: viewController)
            }else{
                self.createLoginToken()
                let nextVC = viewController.storyboard?.instantiateViewController(withIdentifier: "tabBar")as! TabBarViewController
                viewController.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    
    func resetPassword() {
        return
    }
    
    
    func singup(email: String, password: String, name: String, viewController: UIViewController) {
        if email == "" || password == "" || name == "" {
            alert.alertCreate(title: "入力されていない項目があります。", message: "", actionTitle: "OK", viewCotroller: viewController)
            return
        }else if password.count < 7 {
            alert.alertCreate(title: "パスワードは8文字以上にしてください。", message: "", actionTitle: "OK", viewCotroller: viewController)
            return
        }else{
            createUser(email: email, password: password, name: name, viewController: viewController)
            createLoginToken()
            let nextVC = viewController.storyboard?.instantiateViewController(withIdentifier: "tabBar")as! TabBarViewController
            viewController.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
    //入力された情報元にFirebaseでユーザーを作成します。(func signup)
    private func createUser(email: String, password: String, name: String, viewController: UIViewController) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.alert.alertCreate(title: "エラー", message: "\(String(describing: error))", actionTitle: "OK", viewCotroller: viewController)
            }else{
                guard let uid = Auth.auth().currentUser?.uid else { return }
                self.UserDefalutSetData(uid: uid, name: name)
            }
        }
    }
    
    
    //プロフィール初期画像とユーザーIDをUserDefalutに保存します。(func signup)
    private func UserDefalutSetData(uid: String, name: String) {
        guard let profileImage = UIImage(named: "noimage") else { return }
        guard let profileImageData = profileImage.jpegData(compressionQuality: 0.1) else { return }
        UserDefaults.standard.set(profileImageData, forKey: "profileImageData")
        UserDefaults.standard.set(uid, forKey: "uid")
        UserDefaults.standard.set(name, forKey: "userName")
    }
    
    
    //自動ログインで使用するトークンを作成します。(func login, func signup)
    private func createLoginToken() {
        UserDefaults.standard.set(true, forKey: "loginToken")
    }
    
}
