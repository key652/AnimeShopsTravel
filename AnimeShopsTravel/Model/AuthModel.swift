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
    func resetPassword(viewController: UIViewController)
    func singup(email: String, password: String, name: String, viewController: UIViewController)
    func logout(viewController: UIViewController)
}



class AuthModel: AuthDelegate {
    private let alert = AlertCreateView()
    private let userDefaultsModel = UserDefaultsModel()
    
    
    func login(email: String, password: String, viewController: UIViewController) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.alert.alertCreate(title: "エラー", message: error!.localizedDescription, actionTitle: "OK", viewCotroller: viewController)
            }else{
                self.userDefaultsModel.createLoginToken()
                guard let nextVC = viewController.storyboard?.instantiateViewController(withIdentifier: "tabBar") else
                { return }
                viewController.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    
    func resetPassword(viewController: UIViewController) {
        let resetAlert = UIAlertController(title: "パスワードをリセット", message: "メールアドレスを入力してください", preferredStyle: .alert)
        resetAlert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        resetAlert.addAction(UIAlertAction(title: "リセット", style: .default, handler: { (action) in
            guard let resetEmail = resetAlert.textFields?.first?.text else { return }
            self.sendResetEmail(email: resetEmail, viewController: viewController)
        }))
        resetAlert.addTextField { (textField) in
            textField.placeholder = "e-mail"
        }
        viewController.present(resetAlert, animated: true, completion: nil)
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
        }
    }
    
    
    func logout(viewController: UIViewController) {
        do {
            try Auth.auth().signOut()
            userDefaultsModel.removeLoginToken()
            let nextVC = viewController.storyboard?.instantiateViewController(withIdentifier: "login")as! LoginViewController
            viewController.navigationController?.pushViewController(nextVC, animated: true)
            } catch {
                alert.alertCreate(title: "エラー", message: error.localizedDescription, actionTitle: "OK", viewCotroller: viewController)
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
                self.userDefaultsModel.createLoginToken()
                let nextVC = viewController.storyboard?.instantiateViewController(withIdentifier: "tabBar")as! TabBarViewController
                viewController.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    
    //プロフィール初期画像とユーザーIDをUserDefalutに保存します。(func signup)
    private func UserDefalutSetData(uid: String, name: String) {
        UserDefaults.standard.removeObject(forKey: "profileImageData")
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "uid")
        guard let profileImage = UIImage(named: "noimage") else { return }
        guard let profileImageData = profileImage.jpegData(compressionQuality: 0.1) else { return }
        UserDefaults.standard.set(profileImageData, forKey: "profileImageData")
        UserDefaults.standard.set(uid, forKey: "uid")
        UserDefaults.standard.set(name, forKey: "userName")
    }
    
    
    private func sendResetEmail(email: String, viewController: UIViewController) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            DispatchQueue.main.async {
                if error != nil {
                    self.alert.alertCreate(title: "エラー", message: error!.localizedDescription, actionTitle: "OK", viewCotroller: viewController)
                    return
                }
                self.alert.alertCreate(title: "メールを送信しました", message: "メールでパスワードの再設定を行って下さい", actionTitle: "OK", viewCotroller: viewController)
            }
        }
    }
    
    
}
