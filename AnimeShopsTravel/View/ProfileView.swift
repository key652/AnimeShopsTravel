//
//  ProfileView.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/31.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    var profileImageView = UIImageView()
    var userNameTextField = UITextField()
    var changeProfileButton = UIButton()
    
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
        addSubview(userNameTextField)
        addSubview(changeProfileButton)
        
        userNameTextField.borderStyle = .bezel
        changeProfileButton.setTitle("更新", for: .normal)
        changeProfileButton.setTitleColor(UIColor.white, for: .normal)
        changeProfileButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        changeProfileButton.backgroundColor = CustomColor.mainColor
        
        changeProfileButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        changeProfileButton.layer.shadowColor = UIColor.black.cgColor
        changeProfileButton.layer.shadowOpacity = 0.6
        
    }
    
    private func setLayout() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        changeProfileButton.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 46).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 142).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -142).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true
        
        userNameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 46).isActive = true
        userNameTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 44).isActive = true
        userNameTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -44).isActive = true
        userNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        changeProfileButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -159).isActive = true
        changeProfileButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 57).isActive = true
        changeProfileButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -57).isActive = true
        changeProfileButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    
}
