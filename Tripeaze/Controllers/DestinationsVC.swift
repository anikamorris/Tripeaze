//
//  DestinationsVC.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit

class DestinationsController: UIViewController {
    
    //MARK: Properties
    var coordinator: TabBarCoordinator!
    var destinations: [Destination] = [Destination(name: "Italy")]
    
    //MARK: Views
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DestinationCell.self, forCellReuseIdentifier: DestinationCell.identifier)
        return tableView
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        setUpViews()
    }
    
    //MARK: Methods
    private func setUpViews() {
        view.backgroundColor = .backgroundColor
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DestinationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DestinationCell.identifier) as! DestinationCell
        cell.set(destinations[indexPath.row])
        return cell
    }
}

extension DestinationsController: UITableViewDelegate {
    
}
