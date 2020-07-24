//
//  SignupView.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class SignupView: UIView {
    var nameTextField = UITextField()
    var addressTextField = UITextField()
    var passwordTextField = UITextField()
    var signupButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        addSubview(nameTextField)
        addSubview(addressTextField)
        addSubview(passwordTextField)
        addSubview(signupButton)
        
        passwordTextField.isSecureTextEntry = true
        
        nameTextField.placeholder = "ユーザー名"
        addressTextField.placeholder = "メールアドレス"
        passwordTextField.placeholder = "パスワード"
        
        nameTextField.borderStyle = .bezel
        addressTextField.borderStyle = .bezel
        passwordTextField.borderStyle = .bezel
        
        signupButton.setTitle("新規登録", for: .normal)
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.backgroundColor = CustomColor.mainColor
        signupButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
        signupButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        signupButton.layer.shadowColor = UIColor.black.cgColor
        signupButton.layer.shadowOpacity = 0.6
        
        
    }
    
    private func setLayout() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -45).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addressTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30).isActive = true
        addressTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        addressTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -45).isActive = true
        addressTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 30).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -45).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signupButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 57).isActive = true
        signupButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -57).isActive = true
        signupButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -147).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
}
