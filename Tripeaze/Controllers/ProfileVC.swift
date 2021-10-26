//
//  ProfileVC.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit

class ProfileController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: ProfileCoordinator?
    
    //MARK: Views
    let profileStackView = ProfileStackView()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        setUpViews()
    }
    
    //MARK: Methods
    private func setUpViews() {
        view.backgroundColor = .backgroundColor
        view.addSubview(profileStackView)
        NSLayoutConstraint.activate([
            profileStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            profileStackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
