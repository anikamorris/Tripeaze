//
//  GroupCell.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/27/21.
//

import Foundation
import UIKit

class GroupCell: UITableViewCell {
    
    // MARK: Properties
    static let identifier: String = "GroupCell"
    var group: Group?
    
    //MARK: Subviews
    let nameLabel: UILabel = {
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
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    func set(_ group: Group) {
        self.group = group
        nameLabel.text = group.groupID
    }
}
