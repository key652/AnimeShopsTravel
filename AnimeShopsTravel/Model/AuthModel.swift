//
//  AuthModel.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import Foundation
import Firebase

protocol AuthDelegate: class {
    func login(email: String, password: String, viewController: UIViewController)
    func resetPassword()
}

class AuthModel: AuthDelegate {
    
    let alert = AlertCreateView()
    
    func login(email: String, password: String, viewController: UIViewController) {
        if email == "" || password == "" {
            alert.alertCreate(title: "入力されていない箇所があります。", message: "", actionTitle: "OK", viewCotroller: viewController)
        }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.alert.alertCreate(title: "メールアドレスまたはパスワードが間違っています。", message: "", actionTitle: "OK", viewCotroller: viewController)
            }else{
                UserDefaults.standard.set(true, forKey: "loginToken")
                let nextVC = viewController.storyboard?.instantiateViewController(withIdentifier: "map")as! MapViewController
                viewController.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    func resetPassword() {
        return
    }
    
    
}
