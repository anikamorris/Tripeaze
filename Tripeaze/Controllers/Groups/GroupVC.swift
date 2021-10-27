//
//  GroupVC.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/27/21.
//

import Foundation
import UIKit

class GroupController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: GroupCoordinator?
    let authManager = FirebaseAuthManager()
    var groups = [Group]()
    
    //MARK: Subviews
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
    let groupTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let createGroupButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Group", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(createGroupTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        groupTableView.delegate = self
        groupTableView.dataSource = self
        getGroups()
        setUpViews()
    }
    
    //MARK: Methods
    private func setUpViews() {
        view.backgroundColor = .backgroundColor
        view.addSubview(friendTextField)
        view.addSubview(findFriendButton)
        view.addSubview(createGroupButton)
        view.addSubview(groupTableView)
        NSLayoutConstraint.activate([
            friendTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            friendTextField.heightAnchor.constraint(equalToConstant: 40),
            friendTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            friendTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            findFriendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            findFriendButton.heightAnchor.constraint(equalToConstant: 40),
            findFriendButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            findFriendButton.topAnchor.constraint(equalTo: friendTextField.bottomAnchor, constant: 20),
            
            createGroupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createGroupButton.heightAnchor.constraint(equalToConstant: 40),
            createGroupButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            createGroupButton.topAnchor.constraint(equalTo: findFriendButton.bottomAnchor, constant: 50),
            
            groupTableView.topAnchor.constraint(equalTo: createGroupButton.bottomAnchor, constant: 20),
            groupTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            groupTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            groupTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getGroups() {
        authManager.getGroups() { [weak self] groups in
            self?.groups = groups
            self?.groupTableView.reloadData()
        }
    }
    
    private func display(_ alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func findFriendTapped() {
        guard let username = friendTextField.text, !username.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let alertController = UIAlertController(title: nil, message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        authManager.addFriend(username: username) { [weak self] success in
            if success {
                alertController.message = "\(username) has been added to this group."
            } else {
                alertController.message = "We couldn't find \(username). Please try another username."
            }
//            self?.display(alertController)
        }
    }
    
    @objc func createGroupTapped() {
        let groupKey = authManager.createGroup()
        guard let groupID = groupKey else {
            let alertController = UIAlertController(title: nil, message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            alertController.message = "Error creating group. Please try again."
//            display(alertController)
            return
        }
        let group = Group(groupID: groupID, creator: authManager.getCurrentUser()!.uid)
        self.groups.append(group)
        groupTableView.reloadData()
    }
}

extension GroupController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier) as! GroupCell
        cell.set(groups[indexPath.row])
        return cell
    }
}

extension GroupController: UITableViewDelegate {
    
}
