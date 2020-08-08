//
//  SignupViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    private let myView = SignupView()
    private let authModel = AuthModel()
    weak var authDelegate:AuthDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9796229005, blue: 0.9598469873, alpha: 1)
        view.sendSubviewToBack(view)
        navigationController?.navigationBar.barTintColor = CustomColor.mainColor
        myView.nameTextField.delegate = self
        myView.addressTextField.delegate = self
        myView.passwordTextField.delegate = self
        self.authDelegate = authModel
        ButtonActionSet()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpNotificationForButton()
    }
    
    @objc private func signupButtonTaped() {
        guard let userName = myView.nameTextField.text else { return }
        guard let email = myView.addressTextField.text else { return }
        guard let password = myView.passwordTextField.text else { return }
        authDelegate?.singup(email: email, password: password, name: userName, viewController: self)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myView.nameTextField.resignFirstResponder()
        myView.addressTextField.resignFirstResponder()
        myView.passwordTextField.resignFirstResponder()
    }
    
    
    private func ButtonActionSet() {
        myView.signupButton.addTarget(self, action: #selector(signupButtonTaped), for: .touchUpInside)
    }
    
    
    private func setUpNotificationForButton() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]as! NSValue).cgRectValue
        let keyboardOriginY = view.frame.size.height - keyboardSize.height
        let signupButtonOriginY = myView.signupButton.frame.origin.y
        if keyboardOriginY < signupButtonOriginY {
            myView.signupConstraint?.constant = -(view.frame.size.height - keyboardOriginY)
        }
    }
    
    
    @objc private func keyboardWillHide(notification: Notification) {
        myView.signupConstraint?.constant = -125
    }
}

extension SignupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myView.nameTextField.resignFirstResponder()
        myView.addressTextField.resignFirstResponder()
        myView.passwordTextField.resignFirstResponder()
        return true
    }
    
}
