//
//  LoginView.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/23.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class LoginView: UIView {
    var addressTextField = UITextField()
    var passwordTextField = UITextField()
    var loginButton = UIButton()
    var signupButton = UIButton()
    var resetPasswordButton = UIButton()
    var loginConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        addSubview(addressTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(signupButton)
        addSubview(resetPasswordButton)
        
        passwordTextField.isSecureTextEntry = true
        
        addressTextField.placeholder = "メールアドレス"
        passwordTextField.placeholder = "パスワード"
        
        addressTextField.borderStyle = .bezel
        passwordTextField.borderStyle = .bezel
        
        loginButton.setTitle("ログイン", for: .normal)
        signupButton.setTitle("アカウント作成", for: .normal)
        resetPasswordButton.setTitle("パスワードをお忘れになった場合", for: .normal)
        
        loginButton.setTitleColor(UIColor.black, for: .normal)
        signupButton.setTitleColor(UIColor.black, for: .normal)
        resetPasswordButton.setTitleColor(UIColor.blue, for: .normal)
        
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signupButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        resetPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        loginButton.backgroundColor = CustomColor.mainColor
        signupButton.backgroundColor = #colorLiteral(red: 1, green: 0.9796229005, blue: 0.9598469873, alpha: 1)
        
        loginButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOpacity = 0.3
        
    }
    
    private func setLayout() {
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        addressTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        addressTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        addressTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -45).isActive = true
        addressTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 35).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -45).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        loginConstraint = loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -125)
        loginConstraint?.isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        signupButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 57).isActive = true
        signupButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -57).isActive = true
        signupButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -66).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        resetPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 13).isActive = true
        resetPasswordButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -44).isActive = true
        resetPasswordButton.widthAnchor.constraint(equalToConstant: 230).isActive = true
        resetPasswordButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
}
