//
//  SettingView.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/27.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class SettingView: UIView {
    var profileImageView = UIImageView()
    var userNameLabel = UILabel()
    var settingProfileButton = UIButton()
    var logoutButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(settingProfileButton)
        addSubview(logoutButton)
        
        userNameLabel.textAlignment = .center
        settingProfileButton.setTitle("プロフィール設定", for: .normal)
        logoutButton.setTitle("ログアウト", for: .normal)
        
        settingProfileButton.setTitleColor(UIColor.black, for: .normal)
        logoutButton.setTitleColor(UIColor.black, for: .normal)
        
        settingProfileButton.backgroundColor = CustomColor.mainColor
        logoutButton.backgroundColor = CustomColor.logoutButtonColor
        
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 21)
        settingProfileButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        settingProfileButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        settingProfileButton.layer.shadowColor = UIColor.black.cgColor
        settingProfileButton.layer.shadowOpacity = 0.3
        
    }
    
    
    private func setLayout() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        settingProfileButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 46).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 142).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -142).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true
        
        userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 46).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 44).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -44).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        settingProfileButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -159).isActive = true
        settingProfileButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 57).isActive = true
        settingProfileButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -57).isActive = true
        settingProfileButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        logoutButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        logoutButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        logoutButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
    }
}
