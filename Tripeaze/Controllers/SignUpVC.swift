//
//  SignUpVC.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit
import FirebaseAuth

class SignUpController: UIViewController {
    
    //MARK: Properties
    
    //MARK: Subviews
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        setUpViews()
    }
    
    //MARK: Methods
    private func setUpViews() {
        view.backgroundColor = .backgroundColor
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func didTapSignUpButton() {
        let signUpManager = FirebaseAuthManager()
        if let email = emailTextField.text, let password = passwordTextField.text {
            signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully created."
                    self.navigationController?.pushViewController(MainTabBarController(), animated: true)
                } else {
                    message = "There was an error."
                }
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.display(alertController: alertController)
            }
        }
    }
}
