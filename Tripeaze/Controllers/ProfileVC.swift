//
//  ProfileVC.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit
import FirebaseAuth

class ProfileController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: ProfileCoordinator?
    let authManager = FirebaseAuthManager()
    let user: FirebaseAuth.User = FirebaseAuthManager().getCurrentUser()!
    
    //MARK: Views
    let profileStackView = ProfileStackView()
    let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign out", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let friendTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Find a friend by username."
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let findFriendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add friend", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(findFriendTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNameLabel()
    }
    
    //MARK: Methods
    private func setUpViews() {
        profileStackView.usernameLabel.text = user.email!
        view.backgroundColor = .backgroundColor
        view.addSubview(friendTextField)
        view.addSubview(findFriendButton)
        view.addSubview(profileStackView)
        view.addSubview(signOutButton)
        NSLayoutConstraint.activate([
            friendTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            friendTextField.heightAnchor.constraint(equalToConstant: 40),
            friendTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            friendTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            findFriendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            findFriendButton.heightAnchor.constraint(equalToConstant: 40),
            findFriendButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            findFriendButton.topAnchor.constraint(equalTo: friendTextField.bottomAnchor, constant: 20),
            
            profileStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            profileStackView.heightAnchor.constraint(equalToConstant: 200),
            
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: 40),
            signOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            signOutButton.topAnchor.constraint(equalTo: profileStackView.bottomAnchor, constant: 40)
        ])
    }
    
    private func setNameLabel() {
        authManager.getUsername { [weak self] name in
            guard let `self` = self else { return }
            self.profileStackView.nameLabel.text = name
        }
    }
    
    private func display(_ alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func signOutTapped() {
        coordinator?.signOut()
    }
    
    @objc func findFriendTapped() {
        guard let username = friendTextField.text, !username.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let alertController = UIAlertController(title: nil, message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        authManager.addFriend(username: username) { [weak self] success in
            if success {
                alertController.message = "\(username) has been added to your circle."
            } else {
                alertController.message = "We couldn't find \(username). Please try another username."
            }
            self?.display(alertController)
        }
    }
    
    @objc func createGroupTapped() {
//        authManager.createGroup { [weak self] groupID in
//            guard let groupId = groupID else { return }
//            self?.createGroupButton.setTitle(groupId, for: .normal)
//        }
    }
}
