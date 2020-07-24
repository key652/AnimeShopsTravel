//
//  LoginViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    private let myView = LoginView()
    weak var delegate: AuthDelegate?
    private let authModel = AuthModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        view.backgroundColor = UIColor.white
        view.sendSubviewToBack(view)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = CustomColor.mainColor
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
    
    
    private func buttonActionSet() {
        myView.loginButton.addTarget(self, action: #selector(loginButtonTaped), for: .touchUpInside)
        myView.signupButton.addTarget(self, action: #selector(signupButtonTaped), for: .touchUpInside)
        myView.resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTaped), for: .touchUpInside)
    }
    
    
    @objc private func loginButtonTaped() {
        guard let email = myView.addressTextField.text else { return }
        guard let password = myView.passwordTextField.text else { return }
        delegate?.login(email: email, password: password, viewController: self)
    }
    
    
    @objc private func signupButtonTaped() {
        guard let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "signup") else { return }
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    
    @objc private func resetPasswordButtonTaped() {
        delegate?.resetPassword()
    }


}
