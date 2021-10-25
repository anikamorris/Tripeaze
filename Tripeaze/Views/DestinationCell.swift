//
//  DestinationCell.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit

class DestinationCell: UITableViewCell {
    
    // MARK: Properties
    static let identifier: String = "DestinationCell"
    var destination: Destination?
    
    //MARK: Subviews
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    let numVotesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    private func setUpViews() {
        self.addSubview(nameLabel)
        self.addSubview(numVotesLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: numVotesLabel.leadingAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            numVotesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            numVotesLabel.widthAnchor.constraint(equalToConstant: 80),
            numVotesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            numVotesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    func set(_ destination: Destination) {
        self.destination = destination
        nameLabel.text = destination.name
        numVotesLabel.text = "Votes: \(destination.numVotes)"
    }
}
