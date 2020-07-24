//
//  SignupViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate{
    private let myView = SignupView()
    private let authModel = AuthModel()
    weak var delegate:AuthDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        view.backgroundColor = UIColor.white
        view.sendSubviewToBack(view)
        navigationController?.navigationBar.barTintColor = CustomColor.mainColor
        myView.nameTextField.delegate = self
        myView.addressTextField.delegate = self
        myView.passwordTextField.delegate = self
        self.delegate = authModel
        ButtonActionSet()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myView.nameTextField.resignFirstResponder()
        myView.addressTextField.resignFirstResponder()
        myView.passwordTextField.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myView.nameTextField.resignFirstResponder()
        myView.addressTextField.resignFirstResponder()
        myView.passwordTextField.resignFirstResponder()
        return true
    }
    
    
    private func ButtonActionSet() {
        myView.signupButton.addTarget(self, action: #selector(signupButtonTaped), for: .touchUpInside)
    }
    
    
    @objc private func signupButtonTaped() {
        guard let userName = myView.nameTextField.text else { return }
        guard let email = myView.addressTextField.text else { return }
        guard let password = myView.passwordTextField.text else { return }
        delegate?.singup(email: email, password: password, name: userName, viewController: self)
    }


}
