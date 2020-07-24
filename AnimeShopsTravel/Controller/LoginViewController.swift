//
//  LoginViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    var myView = LoginView()
    weak var delegate: AuthDelegate?
    var authModel = AuthModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        view.backgroundColor = UIColor.white
        view.sendSubviewToBack(view)
        myView.addressTextField.delegate = self
        myView.passwordTextField.delegate = self
        self.delegate = authModel
        buttonActionSet()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myView.addressTextField.resignFirstResponder()
        myView.passwordTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myView.addressTextField.resignFirstResponder()
        myView.passwordTextField.resignFirstResponder()
        return true
    }
    
    func buttonActionSet() {
        myView.loginButton.addTarget(self, action: #selector(loginButtonTaped), for: .touchUpInside)
        myView.signupButton.addTarget(self, action: #selector(signupButtonTaped), for: .touchUpInside)
        myView.resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTaped), for: .touchUpInside)
    }
    
    @objc func loginButtonTaped() {
        guard let email = myView.addressTextField.text else { return }
        guard let password = myView.passwordTextField.text else { return }
        delegate?.login(email: email, password: password, viewController: self)
    }
    
    @objc func signupButtonTaped() {
        
    }
    
    @objc func resetPasswordButtonTaped() {
        delegate?.resetPassword()
    }


}
