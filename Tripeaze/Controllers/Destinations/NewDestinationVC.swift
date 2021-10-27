//
//  NewDestinationVC.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit

class NewDestinationController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: DestinationCoordinator?
    
    //MARK: Subviews
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Where would you like to go?"
        return textField
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        setUpViews()
    }
    
    //MARK: Methods
    private func setUpViews() {
        view.backgroundColor = .backgroundColor
        view.addSubview(nameTextField)
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        ])
    }
    
    @objc func saveButtonTapped() {
        guard let name = nameTextField.text else { return }
        let destinationManager = FirebaseDestinationManager()
        if !name.isEmpty {
            let destination = Destination(name)
            destinationManager.createDestination(destination: destination)
            coordinator?.saveDestination(destination)
        }
    }
}
