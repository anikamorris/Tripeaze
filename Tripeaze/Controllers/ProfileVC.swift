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
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        setUpViews()
    }
    
    //MARK: Methods
    private func setUpViews() {
//        profileStackView.nameLabel.text = user.displayName!
        profileStackView.usernameLabel.text = user.email!
        view.backgroundColor = .backgroundColor
        view.addSubview(profileStackView)
        view.addSubview(signOutButton)
        NSLayoutConstraint.activate([
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
    
    @objc func signOutTapped() {
        coordinator?.signOut()
    }
}
