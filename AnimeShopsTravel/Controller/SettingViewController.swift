//
//  SettingViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/27.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {
    private let myView = SettingView()
    private var profileImageData = Data()
    private let userDefaultsModel = UserDefaultsModel()
    private let authModel = AuthModel()
    weak var authDelegate: AuthDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        view.backgroundColor = UIColor.white
        view.sendSubviewToBack(view)
        setProfileData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myView.profileImageView.backgroundColor = UIColor.red
        myView.profileImageView.layer.masksToBounds = false
        myView.profileImageView.layer.cornerRadius = myView.profileImageView.frame.width / 2.0
        myView.profileImageView.clipsToBounds = true
    }
    
    
    private func setProfileData() {
        myView.userNameLabel.text = userDefaultsModel.getMyUserName()
        let profileImageData:Data = userDefaultsModel.getProfileImageData()
        myView.profileImageView.image = UIImage(data: profileImageData)
    }
    
    
    private func setButtonAction() {
        myView.settingProfileButton.addTarget(self, action: #selector(settingProfileButtonTaped), for: .touchUpInside)
        myView.logoutButton.addTarget(self, action: #selector(logoutButtonTaped), for: .touchUpInside)
    }
    
    
    @objc private func settingProfileButtonTaped() {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "profile") else { return }
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    @objc private func logoutButtonTaped() {
        self.authDelegate = authModel
        let logoutAlert = UIAlertController(title: "ログアウトしますか？", message: "", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "ログアウト", style: .default) { (alert) in
            self.authDelegate?.logout(viewController: self)
        }
        let cancel = UIAlertAction(title: "ログアウト", style: .cancel, handler: nil)
        logoutAlert.addAction(logoutAction)
        logoutAlert.addAction(cancel)
        self.present(logoutAlert, animated: true, completion: nil)
    }
    


}


